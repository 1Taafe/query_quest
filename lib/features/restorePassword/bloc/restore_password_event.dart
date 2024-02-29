abstract class RestorePasswordEvent{

}

class ResetRestorePasswordScreenEvent extends RestorePasswordEvent{

}

class RestorePasswordRequestEvent extends RestorePasswordEvent{
  final String email;

  RestorePasswordRequestEvent(this.email);
}

class CheckRestoreCodeEvent extends RestorePasswordEvent{
  final String email;
  final String code;

  CheckRestoreCodeEvent(this.email, this.code);
}

class ChangePasswordEvent extends RestorePasswordEvent{
  final String email;
  final String code;
  final String password;

  ChangePasswordEvent(this.email, this.code, this.password);
}
