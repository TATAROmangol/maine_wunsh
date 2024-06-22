import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:maine_app/domain/repository_models/realm_models.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/root_task_bloc/root_task_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/subtask_bloc/subtask_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/complete_tasks/widgets/complete_subtask_widget.dart';

class CompleteRootTaskWidget extends StatefulWidget {
  const CompleteRootTaskWidget(
      {required this.task,
      required this.isActive,
      required this.currentBloc,
      required this.parentBloc,
      super.key});

  final Task task;
  final bool isActive;
  final RootTaskBloc currentBloc;
  final TasksTreesBloc parentBloc;

  @override
  CompleteRootTaskWidgetState createState() => CompleteRootTaskWidgetState();
}

class CompleteRootTaskWidgetState extends State<CompleteRootTaskWidget> {
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
    final UserTheme theme = GetIt.I.get<UserTheme>();
    //ты писька
    return BlocListener<TasksTreesBloc, TasksTreesState>(
      bloc: widget.parentBloc,
      listener: (context, state) {
        if (state is ShowCompleteTasksTreesState) {
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
                    margin: EdgeInsets.only(
                      top: screenSize.height * 0.013,
                      left: screenSize.width * 0.045,
                      right: screenSize.width * 0.045,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              state is ShowRootTaskState
                                  ? widget.parentBloc
                                      .add(ShowCompleteTasksTreesEvent())
                                  : widget.parentBloc.add(
                                      ShowCompleteTasksTreesEvent(
                                          activeChildUid: widget.task.uid));
                            },
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    widget.task.name,
                                  ),
                                  const Spacer(),
                                  Text(
                                      DateFormat('dd-MM-yyyy').format(widget.task.closeData!))
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
                            return CompleteSubtaskWidget(
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
