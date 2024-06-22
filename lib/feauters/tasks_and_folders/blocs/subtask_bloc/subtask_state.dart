part of 'subtask_bloc.dart';

class SubtaskState {}

class SubtaskStateInitial extends SubtaskState {}

class CloseSubtaskState extends SubtaskState {}

class ShowSubtaskState extends SubtaskState {
  ShowSubtaskState(
      {required this.children,
      required this.activeChildUid,
      required this.childrenComplete});
  final List<Task> children;
  final String activeChildUid;
  final bool childrenComplete;
}



class EndChangeOrderSubtaskChildrenState extends SubtaskState {
  EndChangeOrderSubtaskChildrenState({required this.children});
  final List<Task> children;
}
