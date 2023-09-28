abstract class OlympicsEvent{
  late String path;
}

class GetPlannedOlympicsEnvent extends OlympicsEvent{
  String path = 'planned';
}

class GetCurrentOlympicsEnvent extends OlympicsEvent{
  String path = 'current';
}

class GetFinishedOlympicsEnvent extends OlympicsEvent{
  String path = 'finished';
}
