import '../../../repositories/models/Olympics.dart';

abstract class HomeOlympicsState{

}

class GetOlympicsState extends HomeOlympicsState{

}

class DefaultOlympicsState extends HomeOlympicsState{
  final List<Olympics> olympics;
  final String path;

  DefaultOlympicsState(this.olympics, this.path);

}

class EmptyOlympicsState extends HomeOlympicsState{

}

class ErrorOlympicsState extends HomeOlympicsState{

}
