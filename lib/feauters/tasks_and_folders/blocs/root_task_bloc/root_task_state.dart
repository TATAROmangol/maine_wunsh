part of 'root_task_bloc.dart';

class RootTaskState {}

class RootTaskStateInitial extends RootTaskState {}


class CloseRootTaskChildrenState extends RootTaskState {}

class ShowRootTaskState extends RootTaskState {
  ShowRootTaskState(
      {required this.children,
      required this.activeChildUid,
      required this.childrenComplete});
  final List<Task> children;
  final String activeChildUid;
  final bool childrenComplete;
}

class EndChangeOrderRootTaskChildrenState extends RootTaskState {
  EndChangeOrderRootTaskChildrenState({required this.children});
  final List<Task> children;
}
