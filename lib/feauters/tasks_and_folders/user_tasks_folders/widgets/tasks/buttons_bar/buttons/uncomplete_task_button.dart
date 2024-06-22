import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maine_app/domain/repository_models/realm_models.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/root_task_bloc/root_task_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/subtask_bloc/subtask_bloc.dart';

class UncompleteTaskButton extends StatelessWidget {
  const UncompleteTaskButton(
      {required this.parentUid,
      required this.parentBloc,
      required this.task,
      super.key});

  final String parentUid;
  final Bloc parentBloc;
  final Task task;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      child: SizedBox(
        width: screenSize.height * 0.04,
        height: screenSize.height * 0.04,
        child: Center(
          child: Image.asset(
            'assets/icons/uncomplete.png',
            width: screenSize.height * 0.04,
            height: screenSize.height * 0.04,
            fit: BoxFit.contain,
          ),
        ),
      ),
      onTap: () {
        parentBloc is RootTaskBloc
                ? parentBloc.add(UncompleteRootTaskChildEvent(
                    parentUid: parentUid, task: task))
                : parentBloc.add(UncompleteSubtaskaskChildEvent(
                    parentUid: parentUid, task: task));
      },
    );
  }
}
