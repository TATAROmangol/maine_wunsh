import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:maine_app/domain/repository.dart';
import 'package:maine_app/domain/repository_models/realm_models.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/sub_subtask_bloc/sub_subtask_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/subtask_bloc/subtask_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/widgets/tasks/buttons_bar/buttons_bar_widget.dart';

class SubSubtaskWidget extends StatefulWidget {
  const SubSubtaskWidget(
      {required this.task,
      required this.parentTask,
      required this.currentBloc,
      required this.parentBloc,
      super.key});

  final Task task;
  final Task parentTask;
  final SubSubtaskBloc currentBloc;
  final SubtaskBloc parentBloc;

  @override
  SubSubtaskWidgetState createState() => SubSubtaskWidgetState();
}

class SubSubtaskWidgetState extends State<SubSubtaskWidget> {
  final UserTheme theme = GetIt.I.get<UserTheme>();
  final Repository repository = GetIt.I.get<Repository>();

  Color subSubColor(Color color) {
    int green = (color.green - 12).clamp(0, 255);
    int blue = (color.blue - 24).clamp(0, 255);

    return Color.fromARGB(color.alpha, color.red, green, blue);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final Color currentColor = subSubColor(theme.blocsColor);
    final taskData = repository.getNotification(widget.task.uid.hashCode);

    return BlocListener<SubtaskBloc, SubtaskState>(
      bloc: widget.parentBloc,
      listener: (context, state) {
        if (state is ShowSubtaskState) {
          state.activeChildUid != widget.task.uid
              ? widget.currentBloc.add(CloseSubSubtaskEvent())
              : widget.currentBloc.add(ShowSubSubtaskEvent());
        }
      },
      child: BlocBuilder<SubSubtaskBloc, SubSubtaskState>(
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
                      color: !(state is ShowSubSubtaskState ||
                              widget.parentTask.isComplete)
                          ? theme.borderColor.withOpacity(0.5)
                          : theme.borderColor,
                      width: 2.0,
                    ),
                    right: BorderSide(
                      color: !(state is ShowSubSubtaskState ||
                              widget.parentTask.isComplete)
                          ? theme.borderColor.withOpacity(0.5)
                          : theme.borderColor,
                      width: 3.0,
                    ),
                    bottom: BorderSide(
                      color: !(state is ShowSubSubtaskState ||
                              widget.parentTask.isComplete)
                          ? theme.borderColor.withOpacity(0.5)
                          : theme.borderColor,
                      width: 3.0,
                    ),
                    top: BorderSide(
                      color: !(state is ShowSubSubtaskState ||
                              widget.parentTask.isComplete)
                          ? theme.borderColor.withOpacity(0.5)
                          : theme.borderColor,
                      width: 2.0,
                    ),
                  ),
                ),
                height: screenSize.height * 0.07,
                width: screenSize.width * 0.84,
                margin: state is ShowSubSubtaskState
                    ? EdgeInsets.only(
                        left: screenSize.width * 0.115,
                        right: screenSize.width * 0.045,
                      )
                    : EdgeInsets.only(
                        bottom: screenSize.height * 0.013,
                        left: screenSize.width * 0.115,
                        right: screenSize.width * 0.045,
                      ),
                child: widget.parentTask.isComplete
                    ? Padding(
                        padding: EdgeInsets.only(
                            left: screenSize.width * 0.05,
                            right: screenSize.width * 0.05),
                        child: Center(
                          child: Row(
                            children: [
                              Text(widget.task.name,
                              style: 
                                    widget.task.isComplete
                                    ?  const TextStyle(
                                      decoration: TextDecoration.lineThrough)
                                    : const TextStyle(),),
                              const Spacer(),
                              if (taskData != null)
                                Text(
                                    DateFormat('dd-MM-yyyy').format(taskData.scheduledDate!),
                                    style: 
                                    widget.task.isComplete
                                    ?  const TextStyle(
                                      decoration: TextDecoration.lineThrough)
                                    : const TextStyle(),)
                            ],
                          ),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          state is ShowSubSubtaskState
                              ? widget.parentBloc.add(ShowSubtaskEvent(
                                  parentUid: widget.parentTask.uid))
                              : widget.parentBloc.add(ShowSubtaskEvent(
                                  parentUid: widget.parentTask.uid,
                                  activeChildUid: widget.task.uid));
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
                                  style: 
                                    widget.task.isComplete
                                    ?  const TextStyle(
                                      decoration: TextDecoration.lineThrough)
                                    : const TextStyle(),
                                ),
                                const Spacer(),
                                if (taskData != null)
                                  Text(
                                    DateFormat('dd-MM-yyyy').format(taskData.scheduledDate!),
                                    style: 
                                    widget.task.isComplete
                                    ?  const TextStyle(
                                      decoration: TextDecoration.lineThrough)
                                    : const TextStyle(),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
              if (state is ShowSubSubtaskState && !widget.parentTask.isComplete)
                ButtonsBarwidget(
                    parentUid: widget.parentTask.uid,
                    task: widget.task,
                    parentBloc: widget.parentBloc,
                    currentBloc: widget.currentBloc,
                    childrenComplete: true),
            ],
          );
        },
      ),
    );
  }
}
