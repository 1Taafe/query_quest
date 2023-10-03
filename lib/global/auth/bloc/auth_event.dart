import '../../../repositories/models/User.dart';

abstract class AuthEvent{

}

class TokenEvent extends AuthEvent {

}

class LoginEvent extends AuthEvent {
  final User user;
  LoginEvent(this.user);
}