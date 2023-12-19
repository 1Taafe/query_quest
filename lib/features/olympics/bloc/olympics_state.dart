import '../../../repositories/models/Answer.dart';
import '../../../repositories/models/Olympics.dart';
import '../../../repositories/models/Result.dart';
import '../../../repositories/models/Task.dart';

abstract class OlympicsState{}

class OlympicsEmptyState extends OlympicsState{

}

class OlympicsLoadingState extends OlympicsState{

}

class OlympicsUnavailableState extends OlympicsState{
  final Olympics olympics;
  final String currentTime;
  final Result result;
  final List<Answer> answers;
  OlympicsUnavailableState(this.olympics, this.currentTime, this.result, this.answers);
}

class OlympicsAvailableState extends OlympicsState{
  final Olympics olympics;
  final List<Task> tasks;
  OlympicsAvailableState(this.olympics, this.tasks);
}

class OlympicsErrorState extends OlympicsState{
  final String message;
  OlympicsErrorState(this.message);
}