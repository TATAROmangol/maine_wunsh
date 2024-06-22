import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:maine_app/domain/repository.dart';
import 'package:maine_app/domain/repository_models/realm_models.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/root_task_bloc/root_task_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/sub_subtask_bloc/sub_subtask_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/subtask_bloc/subtask_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/widgets/tasks/buttons_bar/buttons_bar_widget.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/widgets/tasks/sub_subtask_widget.dart';

class SubtaskWidget extends StatefulWidget {
  const SubtaskWidget(
      {required this.task,
      required this.parentTask,
      required this.currentBloc,
      required this.parentBloc,
      super.key});

  final Task task;
  final Task parentTask;
  final SubtaskBloc currentBloc;
  final RootTaskBloc parentBloc;

  @override
  SubtaskWidgetState createState() => SubtaskWidgetState();
}

class SubtaskWidgetState extends State<SubtaskWidget> {
  bool showComment = false;
  final UserTheme theme = GetIt.I.get<UserTheme>();
  final Repository repository = GetIt.I.get<Repository>();

  Color subColor(Color color) {
    int green = (color.green - 6).clamp(0, 255);
    int blue = (color.blue - 12).clamp(0, 255);

    return Color.fromARGB(color.alpha, color.red, green, blue);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final Color currentColor = subColor(theme.blocsColor);
    final taskData = repository.getNotification(widget.task.uid.hashCode);

    return BlocListener<RootTaskBloc, RootTaskState>(
      bloc: widget.parentBloc,
      listener: (context, state) {
        if (state is ShowRootTaskState) {
          state.activeChildUid == widget.task.uid
              ? widget.currentBloc
                  .add(ShowSubtaskEvent(parentUid: widget.task.uid))
              : widget.currentBloc.add(CloseSubtaskEvent());
        }
      },
      child: BlocBuilder<SubtaskBloc, SubtaskState>(
        bloc: widget.currentBloc,
        builder: (context, state) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: currentColor,
                  border: Border(
                    left: BorderSide(
                      color: state is! ShowSubtaskState
                          ? theme.borderColor.withOpacity(0.5)
                          : theme.borderColor,
                      width: 2.0,
                    ),
                    right: BorderSide(
                      color: state is! ShowSubtaskState
                          ? theme.borderColor.withOpacity(0.5)
                          : theme.borderColor,
                      width: 3.0,
                    ),
                    bottom: BorderSide(
                      color: state is! ShowSubtaskState
                          ? theme.borderColor.withOpacity(0.5)
                          : theme.borderColor,
                      width: 3.0,
                    ),
                    top: BorderSide(
                      color: state is! ShowSubtaskState
                          ? theme.borderColor.withOpacity(0.5)
                          : theme.borderColor,
                      width: 2.0,
                    ),
                  ),
                ),
                height: screenSize.height * 0.08,
                width: screenSize.width * 0.87,
                margin: state is ShowSubtaskState && state.activeChildUid == ''
                    ? EdgeInsets.only(
                        left: screenSize.width * 0.085,
                        right: screenSize.width * 0.045,
                      )
                    : EdgeInsets.only(
                        bottom: screenSize.height * 0.013,
                        left: screenSize.width * 0.085,
                        right: screenSize.width * 0.045,
                      ),
                child: widget.parentTask.isComplete
                    ? Center(
                        child: Text(
                          widget.task.name,
                          style: widget.task.isComplete
                              ? const TextStyle(
                                  decoration: TextDecoration.lineThrough)
                              : const TextStyle(),
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                if (state is ShowSubtaskState &&
                                    state.activeChildUid != '') {
                                  widget.parentBloc.add(ShowRootTaskEvent(
                                      parentUid: widget.parentTask.uid,
                                      activeChildUid: widget.task.uid));
                                } else if (state is ShowSubtaskState) {
                                  widget.parentBloc.add(ShowRootTaskEvent(
                                      parentUid: widget.parentTask.uid));
                                } else {
                                  widget.parentBloc.add(ShowRootTaskEvent(
                                      parentUid: widget.parentTask.uid,
                                      activeChildUid: widget.task.uid));
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: screenSize.width * 0.05,
                                    right: screenSize.width * 0.05),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.task.name,
                                        style: widget.task.isComplete
                                            ? const TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough)
                                            : const TextStyle(),
                                      ),
                                      const Spacer(),
                                      if (widget.task.isComplete)
                                        Text(
                                            DateFormat('dd-MM-yyyy')
                                                .format(widget.task.closeData!),
                                            style: const TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough))
                                      else if (taskData != null)
                                        Text(
                                          DateFormat('dd-MM-yyyy')
                                              .format(taskData.scheduledDate!),
                                          style: widget.task.isComplete
                                              ? const TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough)
                                              : const TextStyle(),
                                        )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
              ),
              if (state is ShowSubtaskState &&
                  state.activeChildUid == '' &&
                  !widget.parentTask.isComplete)
                ButtonsBarwidget(
                    parentUid: widget.parentTask.uid,
                    task: widget.task,
                    parentBloc: widget.parentBloc,
                    currentBloc: widget.currentBloc,
                    childrenComplete: state.childrenComplete),
              if (state is ShowSubtaskState)
                Column(
                  children: state.children.map(
                    (e) {
                      return BlocProvider<SubSubtaskBloc>(
                        key: ValueKey(e.uid),
                        create: (context) => SubSubtaskBloc(),
                        child: BlocBuilder<SubSubtaskBloc, SubSubtaskState>(
                          builder: (context, state) {
                            return SubSubtaskWidget(
                              task: e,
                              parentTask: widget.task,
                              currentBloc:
                                  BlocProvider.of<SubSubtaskBloc>(context),
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
