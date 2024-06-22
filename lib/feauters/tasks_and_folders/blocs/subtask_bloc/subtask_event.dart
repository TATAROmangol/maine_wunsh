part of 'subtask_bloc.dart';

class SubtaskEvent {}

class CloseSubtaskEvent extends SubtaskEvent {}

class ShowSubtaskEvent extends SubtaskEvent {
  ShowSubtaskEvent(
      {required this.parentUid,
      this.activeChildUid = '',
      this.showComment = false});

  final String parentUid;
  final String activeChildUid;
  final bool showComment;
}

class EndChangeSubtaskOrderChildrenEvent extends SubtaskEvent {
  EndChangeSubtaskOrderChildrenEvent(
      {required this.children, required this.parentUid});
  final List<Task> children;
  final String parentUid;
}

class AddSubtaskChildEvent extends SubtaskEvent {
  AddSubtaskChildEvent(
      {required this.name,
      required this.comment,
      required this.parentUid,
      required this.dateTime});
  final String name;
  final String comment;
  final String parentUid;
  final DateTime? dateTime;
}

class CorrectingSubtaskChildEvent extends SubtaskEvent {
  CorrectingSubtaskChildEvent({
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

class CompleteSubtaskaskChildEvent extends SubtaskEvent {
  CompleteSubtaskaskChildEvent({required this.parentUid, required this.task});
  final String parentUid;
  final Task task;
}

class UncompleteSubtaskaskChildEvent extends SubtaskEvent {
  UncompleteSubtaskaskChildEvent({required this.parentUid, required this.task});
  final String parentUid;
  final Task task;
}

class DeleteSubtaskChildEvent extends SubtaskEvent {
  DeleteSubtaskChildEvent({required this.parentUid, required this.task});
  final String parentUid;
  final Task task;
}
