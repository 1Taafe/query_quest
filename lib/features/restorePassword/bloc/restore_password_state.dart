abstract class RestorePasswordState{

}

class DefaultRestorePasswordState extends RestorePasswordState {

}

class EnterPasswordCodeState extends RestorePasswordState{
  final String email;
  final String code;
  EnterPasswordCodeState(this.email, this.code);
}

class EnterNewPasswordState extends RestorePasswordState{
  final String email;
  final String code;
  final String newPassword;
  EnterNewPasswordState(this.email, this.code, this.newPassword);
}

class LoadingRestorePasswordState extends RestorePasswordState {

}

class ErrorRestorePasswordState extends RestorePasswordState{
  final String message;
  ErrorRestorePasswordState(this.message);
}

class SuccessRestorePasswordState extends RestorePasswordState{
  final String message;
  SuccessRestorePasswordState(this.message);
}

class SuccessChangePasswordState extends RestorePasswordState{

}
