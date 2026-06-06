import 'package:flutter/material.dart';
import 'package:gateway_payments_app/features/checkout/presentation/widgets/payment_methods_list_view.dart';

import 'custom_button_bloc_consumer.dart';

class PaymentMethodsBottomSheet extends StatefulWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  State<PaymentMethodsBottomSheet> createState() =>
      _PaymentMethodsBottomSheetState();
}

class _PaymentMethodsBottomSheetState extends State<PaymentMethodsBottomSheet> {
  bool isPaypal = false;

  checkPaymentMethod({required int index}) {
    if (index == 0) {
      isPaypal = false;
    } else {
      isPaypal = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16),
          PaymentMethodsListView(checkPaymentMethod: checkPaymentMethod),
          SizedBox(height: 32),
          CustomButtonBlocConsumer(isPaypal: isPaypal),
        ],
      ),
    );
  }
}
