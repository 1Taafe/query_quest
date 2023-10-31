abstract class HomeOlympicsEvent{
  late String path;
}

class GetOlympicsEvent extends HomeOlympicsEvent{
  final String path;

  GetOlympicsEvent(this.path);
}
