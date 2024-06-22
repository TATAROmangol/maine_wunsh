import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';

import 'progress_root_tasks.dart';
import 'progress_sub_subtasks.dart';
import 'progress_subtasks.dart';

class ProgressBarsWidget extends StatefulWidget {
  const ProgressBarsWidget({required this.listenBloc, super.key});

  final TasksTreesBloc listenBloc;

  @override
  ProgressBarsWidgetState createState() => ProgressBarsWidgetState();
}

class ProgressBarsWidgetState extends State<ProgressBarsWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TasksTreesBloc>(context).add(ShowCompleteTasksTreesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final tasksTreesBloc = BlocProvider.of<TasksTreesBloc>(context);

    return BlocListener<TasksTreesBloc, TasksTreesState>(
      bloc: widget.listenBloc,
      listener: (context, state) {
        if (state is ReloadStatisticRootState) {
          setState(() {
            tasksTreesBloc.add(ReloadStatisticRootEvent());
          });
        }
      },
      child: BlocBuilder<TasksTreesBloc, TasksTreesState>(
          bloc: tasksTreesBloc,
          builder: (context, state) {
            return Column(
              children: [
                ProgressRootTaskWidget(),
                ProgressSubtaskWidget(),
                ProgressSubSubtaskWidget(),
              ],
            );
          }),
    );
  }
}
