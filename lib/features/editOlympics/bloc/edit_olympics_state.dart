import '../../../repositories/models/Olympics.dart';
import '../../../repositories/models/Task.dart';

abstract class EditOlympicsState {

}

class EditOlympicsEmptyState extends EditOlympicsState{

}

class EditOlympicsDefaultState extends EditOlympicsState{
  final Olympics olympics;
  final List<Task> tasks;
  final String olympicsPath;
  EditOlympicsDefaultState(this.olympics, this.olympicsPath, this.tasks);
}

class EditOlympicsLoadingState extends EditOlympicsState{
  final String status;
  EditOlympicsLoadingState(this.status);
}

class EditOlympicsSuccessfulState extends EditOlympicsState{
  final String message;
  final String olympicsPath;
  final bool needToReturn;
  EditOlympicsSuccessfulState(this.message, this.olympicsPath, this.needToReturn);
}

class EditOlympicsErrorState extends EditOlympicsState{
  final String message;
  EditOlympicsErrorState(this.message);
}