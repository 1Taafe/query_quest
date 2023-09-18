import '../../../repositories/models/User.dart';

abstract class SignupEvent {}

class SignupUserEvent extends SignupEvent {
  final User user;

  SignupUserEvent(this.user);
}