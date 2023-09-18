import '../../../../repositories/models/User.dart';

abstract class HomeEvent{}

class GetUserProfileEvent extends HomeEvent{
  final String token;
  GetUserProfileEvent(this.token);
}

class SetDatabaseEvent extends HomeEvent{
  final String database;
  final User user;
  SetDatabaseEvent(this.database, this.user);
}

class LogoutEvent extends HomeEvent{

}