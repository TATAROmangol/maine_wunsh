import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/repository_models/realm_models.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/root_task_bloc/root_task_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/subtask_bloc/subtask_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';

class DeleteTaskButton extends StatefulWidget {
  const DeleteTaskButton(
      {required this.parentBloc,
      required this.task,
      required this.parentUid,
      super.key});

  final Bloc parentBloc;
  final Task task;
  final String parentUid;

  @override
  DeleteTaskButtonState createState() => DeleteTaskButtonState();
}

class DeleteTaskButtonState extends State<DeleteTaskButton> {
  final UserTheme theme = GetIt.I.get<UserTheme>();
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      child: SizedBox(
        width: screenSize.height * 0.04,
        height: screenSize.height * 0.04,
        child: Center(
          child: Image.asset(
            'assets/icons/delete.png',
            width: screenSize.height * 0.04,
            height: screenSize.height * 0.04,
            fit: BoxFit.contain,
          ),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: widget.parentBloc is TasksTreesBloc
                  ? const Text('Удалить мечту?')
                  : const Text('Удалить задачу?'),
              backgroundColor: theme.accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
                side: BorderSide(color: theme.borderColor, width: 2.0),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Отмена'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.parentBloc is TasksTreesBloc
                        ? widget.parentBloc
                            .add(DeleteTasksTreeChildEvent(task: widget.task))
                        : widget.parentBloc is RootTaskBloc
                            ? widget.parentBloc.add(DeleteRootTaskChildEvent(
                                parentUid: widget.parentUid, task: widget.task))
                            : widget.parentBloc.add(DeleteSubtaskChildEvent(
                                parentUid: widget.parentUid,
                                task: widget.task));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Удалить'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
