import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gateway_payments_app/core/utils/api_service.dart';
import 'package:gateway_payments_app/core/utils/app_keys.dart';
import 'package:gateway_payments_app/features/checkout/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:gateway_payments_app/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:gateway_payments_app/features/checkout/data/models/payment_intent_model/payment_intent_model.dart';

class StripeService {
  final ApiService apiService = ApiService();

  Future<PaymentIntentModel> createPaymentIntent(
    PaymentIntentInputModel paymentIntentInput,
  ) async {
    var response = await apiService.post(
      body: paymentIntentInput.toJson(),
      contentType: Headers.formUrlEncodedContentType,
      url: 'https://api.stripe.com/v1/payment_intents',
      token: AppKeys.secretKey,
    );
    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  Future initPaymentSheet({required String paymentIntentClientSecret}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        merchantDisplayName: 'salah saleh',
        paymentIntentClientSecret: paymentIntentClientSecret,
      ),
    );
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment(PaymentIntentInputModel paymentIntentInput) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInput);

    await initPaymentSheet(
      paymentIntentClientSecret: paymentIntentModel.clientSecret!,
    );

    await displayPaymentSheet();
  }

  Future<EphemeralKeyModel> createEphemeralKey(
      {required String customerId}) async {
    var response = await apiService.post(
        body: {'customer': customerId},
        contentType: Headers.formUrlEncodedContentType,
        url: 'https://api.stripe.com/v1/ephemeral_keys',
        token: AppKeys.secretKey,
        headers: {
          'Authorization': "Bearer ${AppKeys.secretKey}",
          'Stripe-Version': '2023-08-16',
        });

    var ephermeralKey = EphemeralKeyModel.fromJson(response.data);

    return ephermeralKey;
  }
}
