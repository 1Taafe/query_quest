import '../../../../repositories/models/User.dart';

abstract class HomeState{}

class GetUserProfileState extends HomeState {

}

class LogoutState extends HomeState {

}

class DefaultState extends HomeState {
  final User currentUser;
  DefaultState(this.currentUser);
}

class SetDatabaseState extends HomeState{
  final String database;

  SetDatabaseState(this.database);
}

class ErrorHomeState extends HomeState {
  final String status;

  ErrorHomeState(this.status);
}