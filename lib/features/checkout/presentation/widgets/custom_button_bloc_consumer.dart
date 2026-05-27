import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gateway_payments_app/features/checkout/presentation/managers/stripe_cubit.dart';
import 'package:gateway_payments_app/features/checkout/presentation/managers/stripe_state.dart';
import 'package:gateway_payments_app/features/checkout/presentation/views/thank_you_view.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../data/models/payment_intent_input_model.dart';

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
            PaymentIntentInputModel paymentIntentInputModel =
                PaymentIntentInputModel(
                  customerId: 'cus_Uau9O0hpkePIZo',
                  amount: '100',
                  currency: 'USD',
                );
            BlocProvider.of<StripeCubit>(
              context,
            ).makePayment(paymentIntentInput: paymentIntentInputModel);
          },
          isLoading: state is StripeLoadingState ? true : false,
          text: 'Continue',
        );
      },
    );
  }
}
