import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/repository_models/realm_models.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/root_task_bloc/root_task_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/sub_subtask_bloc/sub_subtask_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/subtask_bloc/subtask_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/widgets/tasks/buttons_bar/buttons/add_task_button.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/widgets/tasks/buttons_bar/buttons/complete_task_button.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/widgets/tasks/buttons_bar/buttons/correcting_task_button.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/widgets/tasks/buttons_bar/buttons/delete_task.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/widgets/tasks/buttons_bar/buttons/uncomplete_task_button.dart';

import 'buttons/change_tasks_order.dart';

class ButtonsBarwidget extends StatefulWidget {
  const ButtonsBarwidget(
      {required this.parentUid,
      required this.task,
      required this.parentBloc,
      required this.currentBloc,
      required this.childrenComplete,
      super.key});

  final String parentUid;
  final Task task;
  final bool childrenComplete;
  final Bloc parentBloc;
  final Bloc currentBloc;

  @override
  ButtonsBarwidgetState createState() => ButtonsBarwidgetState();
}

class ButtonsBarwidgetState extends State<ButtonsBarwidget> {
  bool showComment = false;
  final UserTheme theme = GetIt.I.get<UserTheme>();

  Color subSubColor(Color color) {
    int green = (color.green - 8).clamp(0, 255);
    int blue = (color.blue - 20).clamp(0, 255);

    return Color.fromARGB(color.alpha, color.red, green, blue);
  }

  Color subColor(Color color) {
    int green = (color.green - 4).clamp(0, 255);
    int blue = (color.blue - 10).clamp(0, 255);

    return Color.fromARGB(color.alpha, color.red, green, blue);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
        color: widget.currentBloc is RootTaskBloc
            ? theme.blocsColor
            : widget.currentBloc is SubtaskBloc
                ? subColor(theme.blocsColor)
                : subSubColor(theme.blocsColor),
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
        ),
      ),
      width: screenSize.width * 0.78,
      margin: widget.currentBloc is RootTaskBloc
          ? EdgeInsets.only(
              bottom: screenSize.height * 0.013,
              left: screenSize.width * 0.09,
              right: screenSize.width * 0.09,
            )
          : widget.currentBloc is SubtaskBloc
              ? EdgeInsets.only(
                  bottom: screenSize.height * 0.013,
                  left: screenSize.width * 0.13,
                  right: screenSize.width * 0.09,
                )
              : EdgeInsets.only(
                  bottom: screenSize.height * 0.013,
                  left: screenSize.width * 0.16,
                  right: screenSize.width * 0.09,
                ),
      child: widget.task.isComplete
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UncompleteTaskButton(
                    parentUid: widget.parentUid,
                    parentBloc: widget.parentBloc,
                    task: widget.task),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (widget.currentBloc is! SubSubtaskBloc)
                      ChangeChildrenTasksOrderButton(
                          task: widget.task, currentBloc: widget.currentBloc),
                    DeleteTaskButton(
                        parentBloc: widget.parentBloc,
                        task: widget.task,
                        parentUid: widget.parentUid),
                    CorrectingTaskButton(
                        parentBloc: widget.parentBloc,
                        parentUid: widget.parentUid,
                        task: widget.task),
                    if (widget.childrenComplete)
                      CompleteTaskButton(
                          parentUid: widget.parentUid,
                          parentBloc: widget.parentBloc,
                          task: widget.task),
                    GestureDetector(
                        child: Container(
                          height: screenSize.height * 0.04,
                          width: screenSize.height * 0.04,
                          margin: EdgeInsets.only(
                              bottom: screenSize.height * 0.006,
                              top: screenSize.height * 0.006),
                          child: Center(
                            child: Image.asset(
                              showComment
                                  ? 'assets/icons/show.png'
                                  : 'assets/icons/unshow.png',
                              width: screenSize.height * 0.035,
                              height: screenSize.height * 0.035,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() => showComment = !showComment);
                        }),
                    if (widget.currentBloc is! SubSubtaskBloc)
                      AddChildTaskButton(
                          currentBloc: widget.currentBloc,
                          parentUid: widget.task.uid),
                  ],
                ),
                if (showComment)
                  Container(
                    width: screenSize.width * 0.78,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: theme.borderColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(screenSize.width * 0.02),
                      child: Center(child: Text(widget.task.comment)),
                    ),
                  )
              ],
            ),
    );
  }
}
