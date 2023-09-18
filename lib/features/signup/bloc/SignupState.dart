abstract class SignupState {}

class DefaultSingupState extends SignupState {

}

class FetchSignupState extends SignupState {

}

class SuccessfulSignupState extends SignupState {
  final String successMessage;

  SuccessfulSignupState(this.successMessage);
}

class ErrorSignupState extends SignupState {
  final String errorMessage;

  ErrorSignupState(this.errorMessage);
}