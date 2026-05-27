import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gateway_payments_app/core/utils/app_keys.dart';
import 'package:gateway_payments_app/features/checkout/presentation/views/my_cart.dart';

void main() async{

   Stripe.publishableKey = AppKeys.stripePublishableKey;
  runApp(const CheckoutApp());
}

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCartView(),
    );
  }
}