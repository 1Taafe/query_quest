import '../../../repositories/models/Answer.dart';
import '../../../repositories/models/Task.dart';

abstract class TaskState{

}

class TaskEmptyState extends TaskState{

}

class TaskLoadingState extends TaskState{

}

class TaskDefaultState extends TaskState{
  final int taskOrderId;
  final Task task;
  final Answer answer;
  TaskDefaultState(this.task, this.answer, this.taskOrderId);
}

class TaskErrorState extends TaskState{
  final String message;
  TaskErrorState(this.message);
}