abstract class OlympicsEvent{}

class OlympicsLoadEvent extends OlympicsEvent{
  final int olympicsId;
  OlympicsLoadEvent(this.olympicsId);
}
