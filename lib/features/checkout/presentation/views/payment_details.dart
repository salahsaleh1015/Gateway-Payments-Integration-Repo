import 'package:flutter/material.dart';
import 'package:gateway_payments_app/core/widgets/cutom_app_bar.dart';
import 'package:gateway_payments_app/features/checkout/presentation/widgets/payment_details_view_body.dart';

class PaymentDetailsView extends StatelessWidget {
  const PaymentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context,title: 'Payment Details'),
      body: const PaymentDetailsViewBody(),
    );
  }
}