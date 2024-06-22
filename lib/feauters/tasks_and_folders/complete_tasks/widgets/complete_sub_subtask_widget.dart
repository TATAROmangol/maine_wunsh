import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:maine_app/domain/repository_models/realm_models.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/subtask_bloc/subtask_bloc.dart';

class CompleteSubSubtaskWidget extends StatefulWidget {
  const CompleteSubSubtaskWidget(
      {required this.task,
      required this.parentTask,
      required this.parentBloc,
      super.key});

  final Task task;
  final Task parentTask;
  final SubtaskBloc parentBloc;

  @override
  CompleteSubSubtaskWidgetState createState() =>
      CompleteSubSubtaskWidgetState();
}

class CompleteSubSubtaskWidgetState extends State<CompleteSubSubtaskWidget> {
  Color subSubColor(Color color) {
    int green = (color.green - 12).clamp(0, 255);
    int blue = (color.blue - 24).clamp(0, 255);

    return Color.fromARGB(color.alpha, color.red, green, blue);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final UserTheme theme = GetIt.I.get<UserTheme>();
    final Color currentColor = subSubColor(theme.blocsColor);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: currentColor,
            border: Border(
              left: BorderSide(
                color: !(widget.parentTask.isComplete)
                    ? theme.borderColor.withOpacity(0.5)
                    : theme.borderColor,
                width: 2.0,
              ),
              right: BorderSide(
                color: !(widget.parentTask.isComplete)
                    ? theme.borderColor.withOpacity(0.5)
                    : theme.borderColor,
                width: 3.0,
              ),
              bottom: BorderSide(
                color: !(widget.parentTask.isComplete)
                    ? theme.borderColor.withOpacity(0.5)
                    : theme.borderColor,
                width: 3.0,
              ),
              top: BorderSide(
                color: !(widget.parentTask.isComplete)
                    ? theme.borderColor.withOpacity(0.5)
                    : theme.borderColor,
                width: 2.0,
              ),
            ),
          ),
          height: screenSize.height * 0.07,
          width: screenSize.width * 0.84,
          margin: EdgeInsets.only(
            top: screenSize.height * 0.013,
            left: screenSize.width * 0.115,
            right: screenSize.width * 0.045,
          ),
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
      ],
    );
  }
}
