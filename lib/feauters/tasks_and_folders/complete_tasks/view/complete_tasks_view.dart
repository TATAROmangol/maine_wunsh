import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/complete_tasks/widgets/complete_task_tree.dart';

class CompleteTasksView extends StatelessWidget {
  const CompleteTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    final UserTheme theme = GetIt.I.get<UserTheme>();
    final listenBloc = BlocProvider.of<TasksTreesBloc>(context);
    return BlocProvider(
      create: (context) => TasksTreesBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Center(child:Text('Достигнутые мечты', style: TextStyle(color: theme.textColor))),
          backgroundColor: theme.accentColor,
          toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        ),
        body: CompleteTaskTreeView(listenBloc: listenBloc),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
