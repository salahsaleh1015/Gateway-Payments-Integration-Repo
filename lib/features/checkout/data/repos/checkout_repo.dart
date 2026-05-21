import 'package:dartz/dartz.dart';
import 'package:gateway_payments_app/core/errors/failures.dart';
import 'package:gateway_payments_app/features/checkout/data/models/payment_intent_input_model.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInput,
  });
}
