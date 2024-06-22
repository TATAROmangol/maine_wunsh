import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/folders_bloc/folders_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/widgets/folders/folders_bar.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/widgets/tasks/buttons_bar/tasks_trees_buttons.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/widgets/tasks/task_tree.dart';

class UserTasksFolders extends StatelessWidget {
  const UserTasksFolders({super.key});

  @override
  Widget build(BuildContext context) {
    final UserTheme theme = GetIt.I.get<UserTheme>();
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider<FoldersBloc>(
            create: (context) => BlocProvider.of<FoldersBloc>(context)),
        BlocProvider<TasksTreesBloc>(
            create: (context) => BlocProvider.of<TasksTreesBloc>(context))
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Мои мечты', style: TextStyle(color: theme.textColor))),
          backgroundColor: theme.accentColor,
          toolbarHeight: screenHeight * 0.05,
        ),
        body:
          Stack(
            children: [
              const Column(
                children: <Widget>[
                  FolderBar(),
                  TaskTreeView(),
                ],
              ),
              Positioned(
                right: screenWidth * 0.03,
                top: screenHeight * 0.65,
                child: const TasksTreesButtons(),
              
          ),
        ]),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
