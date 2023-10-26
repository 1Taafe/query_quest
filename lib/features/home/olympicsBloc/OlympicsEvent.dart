abstract class OlympicsEvent{
  late String path;
}

class GetOlympicsEvent extends OlympicsEvent{
  final String path;

  GetOlympicsEvent(this.path);
}
