import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gateway_payments_app/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:gateway_payments_app/features/checkout/data/repos/checkout_repo.dart';
import 'package:gateway_payments_app/features/checkout/presentation/managers/stripe_state.dart';

class StripeCubit extends Cubit<StripeStates> {
  StripeCubit(this.checkoutRepo) : super(StripeInitialState());
  final CheckoutRepo checkoutRepo;

  Future makePayment({
    required PaymentIntentInputModel paymentIntentInput,
  }) async {
    var data = await checkoutRepo.makePayment(
      paymentIntentInput: paymentIntentInput,
    );
    data.fold((l)=>emit(StripeFailureState(errorMsg: l.errMessage)), (r)=>emit(StripeSuccessState()));
  }

  @override
  void onChange(Change<StripeStates> change) {
    log(change.toString());
    super.onChange(change);
  }
}
