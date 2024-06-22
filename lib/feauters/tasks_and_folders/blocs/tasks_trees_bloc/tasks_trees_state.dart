part of 'tasks_trees_bloc.dart';

class TasksTreesState {}

class TasksTreeStatesInitial extends TasksTreesState {}

class CloseTasksTreesState extends TasksTreesState {
  CloseTasksTreesState({required this.children});
  final List<Task> children;
}

class ChangeOrderTasksTreesState extends TasksTreesState {
  ChangeOrderTasksTreesState();
}

class ShowTasksTreesState extends TasksTreesState {
  ShowTasksTreesState(
      {required this.children,
      required this.parentUid,
      required this.activeChildUid,
      required this.changeOrder});
  final List<Task> children;
  final String parentUid;
  final String activeChildUid;
  final bool changeOrder;
}

class ShowCompleteTasksTreesState extends TasksTreesState {
  ShowCompleteTasksTreesState(
      {required this.children, required this.activeChildUid});
  final List<Task> children;
  final String activeChildUid;
}

class ReloadStatisticRootState extends TasksTreesState {}

class CloseCompleteTasksTreesState extends TasksTreesState {
  CloseCompleteTasksTreesState({required this.children});
  final List<Task> children;
}
