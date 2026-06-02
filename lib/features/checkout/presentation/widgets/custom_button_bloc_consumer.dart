import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gateway_payments_app/features/checkout/presentation/managers/stripe_cubit.dart';
import 'package:gateway_payments_app/features/checkout/presentation/managers/stripe_state.dart';
import 'package:gateway_payments_app/features/checkout/presentation/views/thank_you_view.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/models/stripe_models/payment_intent_input_model.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({super.key});

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
            // PaymentIntentInputModel paymentIntentInputModel =
            //     PaymentIntentInputModel(
            //       customerId: 'cus_Uau9O0hpkePIZo',
            //       amount: '100',
            //       currency: 'USD',
            //     );
            // BlocProvider.of<StripeCubit>(
            //   context,
            // ).makePayment(paymentIntentInput: paymentIntentInputModel);

            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PaypalCheckoutView(
                sandboxMode: true,
                clientId: "",
                secretKey: "",
                transactions: const [
                  {
                    "amount": {
                      "total": '70',
                      "currency": "USD",
                      "details": {
                        "subtotal": '70',
                        "shipping": '0',
                        "shipping_discount": 0
                      }
                    },
                    "description": "The payment transaction description.",

                    "item_list": {
                      "items": [
                        {
                          "name": "Apple",
                          "quantity": 4,
                          "price": '5',
                          "currency": "USD"
                        },
                        {
                          "name": "Pineapple",
                          "quantity": 5,
                          "price": '10',
                          "currency": "USD"
                        }
                      ],

                      // shipping address is not required though
                      //   "shipping_address": {
                      //     "recipient_name": "tharwat",
                      //     "line1": "Alexandria",
                      //     "line2": "",
                      //     "city": "Alexandria",
                      //     "country_code": "EG",
                      //     "postal_code": "21505",
                      //     "phone": "+00000000",
                      //     "state": "Alexandria"
                      //  },
                    }
                  }
                ],
                note: "Contact us for any questions on your order.",
                onSuccess: (Map params) async {
                  print("onSuccess: $params");
                },
                onError: (error) {
                  print("onError: $error");
                  Navigator.pop(context);
                },
                onCancel: () {
                  print('cancelled:');
                },
              ),
            ));
          },
          isLoading: state is StripeLoadingState ? true : false,
          text: 'Continue',
        );
      },
    );
  }
}
