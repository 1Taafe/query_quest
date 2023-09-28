import '../../../repositories/models/Olympics.dart';

abstract class OlympicsState{

}

class GetOlympicsState extends OlympicsState{

}

class DefaultOlympicsState extends OlympicsState{
  final List<Olympics> olympics;

  DefaultOlympicsState(this.olympics);

}

class ErrorOlympicsState extends OlympicsState{

}
