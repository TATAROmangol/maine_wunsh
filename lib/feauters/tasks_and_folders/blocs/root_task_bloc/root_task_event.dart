part of 'root_task_bloc.dart';

class RootTaskEvent {}

class CloseRootTaskEvent extends RootTaskEvent {}

class ShowRootTaskEvent extends RootTaskEvent {
  ShowRootTaskEvent({required this.parentUid, this.activeChildUid = ''});
  final String parentUid;
  final String activeChildUid;
}

class EndChangeRootTaskOrderChildrenEvent extends RootTaskEvent {
  EndChangeRootTaskOrderChildrenEvent(
      {required this.children, required this.parentUid});
  final List<Task> children;
  final String parentUid;
}

class AddRootTaskChildEvent extends RootTaskEvent {
  AddRootTaskChildEvent(
      {required this.name,
      required this.comment,
      required this.parentUid,
      required this.dateTime});
  final String name;
  final String comment;
  final String parentUid;
  final DateTime? dateTime;
}

class DeleteRootTaskChildEvent extends RootTaskEvent {
  DeleteRootTaskChildEvent({required this.parentUid, required this.task});
  final String parentUid;
  final Task task;
}

class CompleteRootTaskChildEvent extends RootTaskEvent {
  CompleteRootTaskChildEvent({required this.parentUid, required this.task});
  final String parentUid;
  final Task task;
}

class UncompleteRootTaskChildEvent extends RootTaskEvent {
  UncompleteRootTaskChildEvent({required this.parentUid, required this.task});
  final String parentUid;
  final Task task;
}

class CorrectingRootTaskChildEvent extends RootTaskEvent {
  CorrectingRootTaskChildEvent({
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
