




import 'package:gateway_payments_app/features/checkout/data/models/stripe_models/payment_intent_model/card.dart';

class PaymentMethodOptions {
  Card? card;

  PaymentMethodOptions({this.card});

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) {
    return PaymentMethodOptions(
      card: json['card'] == null
          ? null
          : Card.fromJson(json['card'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'card': card?.toJson(),
  };
}