import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gateway_payments_app/core/utils/api_service.dart';
import 'package:gateway_payments_app/core/utils/app_keys.dart';
import 'package:gateway_payments_app/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:gateway_payments_app/features/checkout/data/models/payment_intent_model/payment_intent_model.dart';

class StripeService {
  final ApiService apiService = ApiService();

  Future<PaymentIntentModel> createPaymentIntent(
    PaymentIntentInputModel paymentIntentInput,
  ) async {
    var response = await apiService.post(
      body: paymentIntentInput.toJson(),
      url: 'https://api.stripe.com/v1/payment_intents/',
      token: AppKeys.secretKey,
    );
    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }


  Future initPaymentSheet({required String paymentIntentClientSecret})async{
    Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
      merchantDisplayName: 'salah saleh',
      paymentIntentClientSecret: paymentIntentClientSecret,
    ));
  }

  Future displayPaymentSheet()async{
    await Stripe.instance.presentPaymentSheet();
  }
}
