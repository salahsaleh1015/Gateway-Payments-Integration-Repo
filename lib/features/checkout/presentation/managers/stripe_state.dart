abstract class StripeStates {}

final class StripeInitialState extends StripeStates {}

final class StripeLoadingState extends StripeStates {}

final class StripeSuccessState extends StripeStates {}

final class StripeFailureState extends StripeStates {
  final String errorMsg;

  StripeFailureState({required this.errorMsg});
}
