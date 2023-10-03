import '../../../repositories/models/User.dart';

abstract class AuthState{

}

class AuthLoadingState extends AuthState{

}

class UnauthorizedNotifyState extends AuthState{
  final String status;
  UnauthorizedNotifyState(this.status);
}

class AuthorizedNotifyState extends AuthState{
  final String status;
  AuthorizedNotifyState(this.status);
}

class UnauthorizedState extends AuthState{
}

class AuthorizedState extends AuthState{
  final String token;
  final User currentUser;

  AuthorizedState(this.token, this.currentUser);
}