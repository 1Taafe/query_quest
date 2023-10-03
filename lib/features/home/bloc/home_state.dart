import '../../../../repositories/models/User.dart';

abstract class HomeState{}

class LoadingState extends HomeState {

}

class LogoutState extends HomeState {

}

class DefaultState extends HomeState {
  final User currentUser;
  DefaultState(this.currentUser);
}

class DefaultOrganizerState extends HomeState {
  final User currentUser;
  DefaultOrganizerState(this.currentUser);
}

class ErrorHomeState extends HomeState {
  final String status;

  ErrorHomeState(this.status);
}