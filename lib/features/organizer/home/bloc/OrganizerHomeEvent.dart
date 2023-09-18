abstract class OrganizerHomeEvent{}

class GetOrganizerProfileEvent extends OrganizerHomeEvent{
  final String token;
  GetOrganizerProfileEvent(this.token);
}

class OrganizerLogoutEvent extends OrganizerHomeEvent{

}