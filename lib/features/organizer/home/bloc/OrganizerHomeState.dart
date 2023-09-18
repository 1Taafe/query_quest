import '../../../../repositories/models/User.dart';

abstract class OrganizerHomeState{}

class GetOrganizerProfileState extends OrganizerHomeState {

}

class OrganizerLogoutState extends OrganizerHomeState {

}

class OrganizerDefaultState extends OrganizerHomeState {
  final User currentUser;
  OrganizerDefaultState(this.currentUser);
}

class OrganizerErrorHomeState extends OrganizerHomeState {
  final String status;

  OrganizerErrorHomeState(this.status);
}