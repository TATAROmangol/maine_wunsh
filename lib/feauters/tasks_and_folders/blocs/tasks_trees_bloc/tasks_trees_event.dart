part of 'tasks_trees_bloc.dart';

class TasksTreesEvent {}

class ShowTasksTreesEvent extends TasksTreesEvent {
  ShowTasksTreesEvent({this.activeChildUid = '', this.changeOrder = false});
  final String activeChildUid;
  final bool changeOrder;
}

class ShowCompleteTasksTreesEvent extends TasksTreesEvent {
  ShowCompleteTasksTreesEvent({this.activeChildUid = ''});
  final String activeChildUid;
}

class AddTasksTreeEvent extends TasksTreesEvent {
  AddTasksTreeEvent({required this.name, required this.comment, required this.dateTime});
  final String name;
  final String comment;
  final DateTime? dateTime;
}

class CorrectingTasksTreeChildEvent extends TasksTreesEvent {
  CorrectingTasksTreeChildEvent({
    required this.name,
    required this.comment,
    required this.task,
    required this.parentUid,
    required this.dateTime,
  });
  final String name;
  final String comment;
  final Task task;
  final String parentUid;
  final DateTime? dateTime;
}

class ReloadStatisticRootEvent extends TasksTreesEvent {}

class CompleteTasksTreeChildEvent extends TasksTreesEvent {
  CompleteTasksTreeChildEvent({required this.task});
  final Task task;
}

class ChangeOrderTasksTreesEvent extends TasksTreesEvent {
  ChangeOrderTasksTreesEvent({required this.children});
  final List<Task> children;
}

class DeleteTasksTreeChildEvent extends TasksTreesEvent {
  DeleteTasksTreeChildEvent({required this.task});
  final Task task;
}
