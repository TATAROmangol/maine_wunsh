import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/repository.dart';
import 'package:maine_app/domain/repository_models/realm_models.dart';
import 'package:maine_app/domain/steps.dart';
import 'package:maine_app/services/notification_service.dart';

part 'tasks_trees_event.dart';
part 'tasks_trees_state.dart';

class TasksTreesBloc extends Bloc<TasksTreesEvent, TasksTreesState> {
  TasksTreesBloc() : super(TasksTreeStatesInitial()) {
    on<ShowTasksTreesEvent>((event, emit) async {
      var acriveFolder = await repository.getActiveFolder();
      acriveFolder == null
          ? emit(ShowTasksTreesState(
              activeChildUid: event.activeChildUid,
              parentUid: '',
              changeOrder: event.changeOrder,
              children: []))
          : emit(ShowTasksTreesState(
              activeChildUid: event.activeChildUid,
              parentUid: acriveFolder.uid,
              changeOrder: event.changeOrder,
              children:
                  await repository.getTasks(Steps.rootTask, acriveFolder.uid)));
    });
    on<ShowCompleteTasksTreesEvent>((event, emit) async {
      final tasks = await repository.getCompleteTrees();
      emit(ShowCompleteTasksTreesState(
          children: tasks, activeChildUid: event.activeChildUid));
    });
    on<AddTasksTreeEvent>((event, emit) async {
      var activeFolder = await repository.getActiveFolder();
      repository.addTask(
          Steps.rootTask, activeFolder!.uid, event.name, event.comment, event.dateTime);
      add(ShowTasksTreesEvent());
    });
    on<ChangeOrderTasksTreesEvent>((event, emit) async {
      var activeFolder = await repository.getActiveFolder();
      repository.changeTasksOrder(
          event.children, Steps.rootTask, activeFolder!.uid);
      add(ShowTasksTreesEvent(changeOrder: true));
    });
    on<CorrectingTasksTreeChildEvent>((event, emit) async {
      repository.correctingTask(event.parentUid, Steps.rootTask, event.task,
          event.name, event.comment, event.task.isComplete, event.dateTime);
      add(ShowTasksTreesEvent(activeChildUid: event.task.uid));
    });

    on<DeleteTasksTreeChildEvent>((event, emit) async {
      var activeFolder = await repository.getActiveFolder();
      repository.deleteTask(activeFolder!.uid, Steps.rootTask, event.task);
      add(ShowTasksTreesEvent());
    });

    on<CompleteTasksTreeChildEvent>((event, emit) async {
      var activeFolder = await repository.getActiveFolder();
      await repository.correctingTask(activeFolder!.uid, Steps.rootTask, event.task, event.task.name, event.task.comment, true, null);
      await repository.moveToCompleteRootTask(activeFolder.uid, event.task);
      NotificationService.cancelNotification(event.task.uid.hashCode);
      emit(ReloadStatisticRootState());
      add(ShowTasksTreesEvent());
    });

    on<ReloadStatisticRootEvent>((event, emit) async {
      emit(ReloadStatisticRootState());
    });
  }
  final Repository repository = GetIt.I.get<Repository>();
}
