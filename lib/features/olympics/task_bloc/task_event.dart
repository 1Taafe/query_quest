abstract class TaskEvent {

}

class TaskLoadEvent extends TaskEvent{
  final int taskId;
  final int taskOrderId;
  TaskLoadEvent(this.taskId, this.taskOrderId);
}

class TaskCheckEvent extends TaskEvent{
  final int taskOrderId;
  final int taskId;
  final String query;
  TaskCheckEvent(this.taskOrderId, this.taskId, this.query);
}

