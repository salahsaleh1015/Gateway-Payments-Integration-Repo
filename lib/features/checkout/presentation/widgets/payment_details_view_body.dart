import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gateway_payments_app/features/checkout/presentation/views/thank_you_view.dart';
import 'package:gateway_payments_app/features/checkout/presentation/widgets/custom_credit_card.dart';
import 'package:gateway_payments_app/features/checkout/presentation/widgets/payment_methods_list_view.dart';

import '../../../../core/widgets/custom_button.dart';

class PaymentDetailsViewBody extends StatefulWidget {
  const PaymentDetailsViewBody({super.key});

  @override
  State<PaymentDetailsViewBody> createState() => _PaymentDetailsViewBodyState();
}

class _PaymentDetailsViewBodyState extends State<PaymentDetailsViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: PaymentMethodsListView(
            //updatePaymentMethod: ({required int index}) {}
          ),
        ),
        SliverToBoxAdapter(
          child: CustomCreditCard(
            autovalidateMode: autoValidateMode,
            formKey: formKey,
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
              child: CustomButton(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    log('payment');
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const ThankYouView();
                        },
                      ),
                    );
                    autoValidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                text: 'Payment',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
