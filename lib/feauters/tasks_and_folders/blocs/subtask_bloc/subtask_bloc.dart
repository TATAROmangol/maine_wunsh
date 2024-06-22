import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/repository.dart';
import 'package:maine_app/domain/repository_models/realm_models.dart';
import 'package:maine_app/domain/steps.dart';

part 'subtask_event.dart';
part 'subtask_state.dart';

class SubtaskBloc extends Bloc<SubtaskEvent, SubtaskState> {
  SubtaskBloc() : super(SubtaskStateInitial()) {
    on<ShowSubtaskEvent>((event, emit) async {
      final children =
          await repository.getTasks(Steps.subSubtask, event.parentUid);
      var childrenComplete = children.isEmpty
          ? true
          : repository.getStateTasks(Steps.subSubtask, event.parentUid);
      emit(ShowSubtaskState(
          children: children,
          activeChildUid: event.activeChildUid,
          childrenComplete: childrenComplete));
    });
    on<CloseSubtaskEvent>((event, emit) async {
      emit(CloseSubtaskState());
    });
    on<AddSubtaskChildEvent>((event, emit) async {
      repository.addTask(Steps.subSubtask, event.parentUid, event.name,
          event.comment, event.dateTime);
      add(ShowSubtaskEvent(parentUid: event.parentUid));
    });
    on<EndChangeSubtaskOrderChildrenEvent>((event, emit) async {
      repository.changeTasksOrder(
          event.children, Steps.subSubtask, event.parentUid);
      add(ShowSubtaskEvent(parentUid: event.parentUid));
    });
    on<CorrectingSubtaskChildEvent>((event, emit) async {
      repository.correctingTask(event.parentUid, Steps.subSubtask, event.task,
          event.name, event.comment, event.task.isComplete, event.dateTime);
      add(ShowSubtaskEvent(
          parentUid: event.parentUid, activeChildUid: event.task.uid));
    });
    on<DeleteSubtaskChildEvent>((event, emit) async {
      repository.deleteTask(event.parentUid, Steps.subSubtask, event.task);
      add(ShowSubtaskEvent(parentUid: event.parentUid));
    });
    on<CompleteSubtaskaskChildEvent>((event, emit) async {
      await repository.correctingTask(event.parentUid, Steps.subSubtask,
          event.task, event.task.name, event.task.comment, true, null);
      await repository.reloadCompleteChildren(
          event.parentUid, Steps.subSubtask);
      add(ShowSubtaskEvent(
          parentUid: event.parentUid, activeChildUid: event.task.uid));
    });
    on<UncompleteSubtaskaskChildEvent>((event, emit) async {
      await repository.correctingTask(event.parentUid, Steps.subSubtask,
          event.task, event.task.name, event.task.comment, false, null);
      await repository.reloadCompleteChildren(
          event.parentUid, Steps.subSubtask);
      add(ShowSubtaskEvent(
          parentUid: event.parentUid, activeChildUid: event.task.uid));
    });
  }
  final Repository repository = GetIt.I.get<Repository>();
}
