import '../../../repositories/models/User.dart';

abstract class LoginEvent {}

class CheckTokenEvent extends LoginEvent {
}

class UserLoginEvent extends LoginEvent {
  final User user;

  UserLoginEvent(this.user);
}