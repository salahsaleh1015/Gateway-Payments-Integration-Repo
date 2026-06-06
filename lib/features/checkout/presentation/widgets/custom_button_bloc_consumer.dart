import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gateway_payments_app/core/utils/app_keys.dart';
import 'package:gateway_payments_app/features/checkout/data/models/paypal_models/amount_model/amount_model.dart';
import 'package:gateway_payments_app/features/checkout/data/models/paypal_models/amount_model/details.dart';
import 'package:gateway_payments_app/features/checkout/presentation/managers/stripe_cubit.dart';
import 'package:gateway_payments_app/features/checkout/presentation/managers/stripe_state.dart';
import 'package:gateway_payments_app/features/checkout/presentation/views/thank_you_view.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/models/paypal_models/item_list_model/item.dart';
import '../../data/models/paypal_models/item_list_model/item_list_model.dart';
import '../../data/models/stripe_models/payment_intent_input_model.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({super.key, required this.isPaypal});

  final bool isPaypal;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StripeCubit, StripeStates>(
      listener: (context, state) {
        if (state is StripeSuccessState) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const ThankYouView();
              },
            ),
          );
        }

        if (state is StripeFailureState) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(content: Text(state.errorMsg));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(state.errorMsg);
        }
      },
      builder: (context, state) {
        return CustomButton(
          onTap: () {
            if (isPaypal) {
              executePaypalPayment(context);
            } else {
              executeStripePayment(context);
            }
          },
          isLoading: state is StripeLoadingState ? true : false,
          text: 'Continue',
        );
      },
    );
  }

  void executeStripePayment(BuildContext context) {
    PaymentIntentInputModel paymentIntentInputModel = PaymentIntentInputModel(
      customerId: 'cus_Uau9O0hpkePIZo',
      amount: '100',
      currency: 'USD',
    );
    BlocProvider.of<StripeCubit>(
      context,
    ).makePayment(paymentIntentInput: paymentIntentInputModel);
  }

  void executePaypalPayment(BuildContext context) {
    var transactionData = getTransactionData();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (BuildContext context) => PaypalCheckoutView(
              sandboxMode: true,
              clientId: AppKeys.paypalClientId,
              secretKey: AppKeys.paypalSecretKey,
              transactions: [
                {
                  "amount": transactionData.amount.toJson(),
                  "description": "The payment transaction description.",

                  "item_list": transactionData.itemList.toJson(),
                },
              ],
              note: "Contact us for any questions on your order.",
              onSuccess: (Map params) async {
                print("onSuccess: $params");
                Navigator.pop(context);
              },
              onError: (error) {
                print("onError: $error");
                Navigator.pop(context);
              },
              onCancel: () {
                print('cancelled:');
              },
            ),
      ),
    );
  }

  ({AmountModel amount, ItemListModel itemList}) getTransactionData() {
    var amount = AmountModel(
      total: "100",
      currency: 'USD',
      details: Details(shipping: "0", shippingDiscount: 0, subtotal: '100'),
    );

    List<OrderItemModel> orders = [
      OrderItemModel(currency: 'USD', name: 'Apple', price: "4", quantity: 10),
      OrderItemModel(currency: 'USD', name: 'Apple', price: "5", quantity: 12),
    ];

    var itemList = ItemListModel(orders: orders);

    return (amount: amount, itemList: itemList);
  }
}
