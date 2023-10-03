import '../../../repositories/models/Olympics.dart';

abstract class OlympicsState{

}

class GetOlympicsState extends OlympicsState{

}

class DefaultOlympicsState extends OlympicsState{
  final List<Olympics> olympics;

  DefaultOlympicsState(this.olympics);

}

class EmptyOlympicsState extends OlympicsState{

}

class ErrorOlympicsState extends OlympicsState{

}
