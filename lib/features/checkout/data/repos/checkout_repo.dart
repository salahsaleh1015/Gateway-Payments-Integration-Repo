import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gateway_payments_app/core/errors/failures.dart';
import 'package:gateway_payments_app/core/utils/stripe_service.dart';
import 'package:gateway_payments_app/features/checkout/data/models/payment_intent_input_model.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInput,
  });
}

class CheckoutRepoImpl implements CheckoutRepo {
  StripeService stripeService = StripeService();

  @override
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInput,
  }) async {
    try {
      await stripeService.makePayment(paymentIntentInput);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }



}
