abstract class LoginState {
  const LoginState ();
}

class TokenCheckingState extends LoginState {}

class NeedToLoginState extends LoginState {}

class UserLoginState extends LoginState {}

class NeedToReturnState extends LoginState {}

class SuccessfulLoginState extends LoginState{
  final Map<String, String> status;
  SuccessfulLoginState(this.status);
}

class ErrorLoginState extends LoginState {
  final String status;
  ErrorLoginState(this.status);
}