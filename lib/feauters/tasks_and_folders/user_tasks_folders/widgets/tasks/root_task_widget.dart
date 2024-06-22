import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/repository.dart';
import 'package:maine_app/domain/repository_models/realm_models.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/root_task_bloc/root_task_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/subtask_bloc/subtask_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/widgets/tasks/buttons_bar/buttons_bar_widget.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/widgets/tasks/subtask_widget.dart';

class RootTaskWidget extends StatefulWidget {
  const RootTaskWidget(
      {required this.task,
      required this.parentUid,
      required this.isActive,
      required this.currentBloc,
      required this.parentBloc,
      super.key});

  final Task task;
  final String parentUid;
  final bool isActive;
  final RootTaskBloc currentBloc;
  final TasksTreesBloc parentBloc;

  @override
  RootTaskWidgetState createState() => RootTaskWidgetState();
}

class RootTaskWidgetState extends State<RootTaskWidget> {
  final UserTheme theme = GetIt.I.get<UserTheme>();

  final Repository repository = GetIt.I.get<Repository>();

  @override
  void initState() {
    widget.isActive
        ? widget.currentBloc.add(ShowRootTaskEvent(parentUid: widget.task.uid))
        : widget.currentBloc.add(CloseRootTaskEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final taskData = repository.getNotification(widget.task.uid.hashCode);
    //ты писька
    return BlocListener<TasksTreesBloc, TasksTreesState>(
      bloc: widget.parentBloc,
      listener: (context, state) {
        if (state is ShowTasksTreesState) {
          state.activeChildUid == widget.task.uid
              ? widget.currentBloc
                  .add(ShowRootTaskEvent(parentUid: widget.task.uid))
              : widget.currentBloc.add(CloseRootTaskEvent());
        }
      },
      child: BlocBuilder<RootTaskBloc, RootTaskState>(
        bloc: widget.currentBloc,
        builder: (context, state) {
          return Column(
            children: [
              Column(
                children: [
                  Container(
                    decoration: !widget.isActive
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: theme.blocsColor,
                          )
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: theme.blocsColor,
                            border: Border(
                              left: BorderSide(
                                color: theme.borderColor,
                                width: 2.0,
                              ),
                              right: BorderSide(
                                color: theme.borderColor,
                                width: 3.0,
                              ),
                              bottom: BorderSide(
                                color: theme.borderColor,
                                width: 3.0,
                              ),
                              top: BorderSide(
                                color: theme.borderColor,
                                width: 2.0,
                              ),
                            ),
                          ),
                    height: screenSize.height * 0.09,
                    width: screenSize.width * 0.91,
                    margin:
                        state is ShowRootTaskState && state.activeChildUid == ''
                            ? EdgeInsets.only(
                                left: screenSize.width * 0.045,
                                right: screenSize.width * 0.045,
                              )
                            : EdgeInsets.only(
                                bottom: screenSize.height * 0.013,
                                left: screenSize.width * 0.045,
                                right: screenSize.width * 0.045,
                              ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                if (state is ShowRootTaskState &&
                                    state.activeChildUid != '') {
                                  widget.parentBloc.add(ShowTasksTreesEvent(
                                      activeChildUid: widget.task.uid));
                                } else if (state is ShowRootTaskState) {
                                  widget.parentBloc.add(ShowTasksTreesEvent());
                                } else {
                                  widget.parentBloc.add(ShowTasksTreesEvent(
                                      activeChildUid: widget.task.uid));
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: screenSize.width * 0.05, right: screenSize.width * 0.05),
                                child: Center( child: Row(
                                  children: [
                                    Text(widget.task.name),
                                    const Spacer(),
                                    if(taskData != null)
                                      Text(DateFormat('dd-MM-yyyy').format(taskData.scheduledDate!))
                                  ],),),),
                              ),
                        )
                      ],
                    ),
                  ),
                  if (state is ShowRootTaskState && state.activeChildUid == '')
                    ButtonsBarwidget(
                        parentUid: widget.parentUid,
                        task: widget.task,
                        parentBloc: widget.parentBloc,
                        currentBloc: widget.currentBloc,
                        childrenComplete: state.childrenComplete),
                ],
              ),
              if (state is ShowRootTaskState)
                Column(
                  children: state.children.map(
                    (e) {
                      return BlocProvider<SubtaskBloc>(
                        key: ValueKey(e.uid),
                        create: (context) => SubtaskBloc(),
                        child: BlocBuilder<SubtaskBloc, SubtaskState>(
                          builder: (context, state) {
                            return SubtaskWidget(
                              task: e,
                              parentTask: widget.task,
                              currentBloc:
                                  BlocProvider.of<SubtaskBloc>(context),
                              parentBloc: widget.currentBloc,
                            );
                          },
                        ),
                      );
                    },
                  ).toList(),
                ),
            ],
          );
        },
      ),
    );
  }
}
