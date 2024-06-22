import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/custom_bottom_navigation_bar.dart';
import 'package:maine_app/feauters/profile/view/profile_view.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/folders_bloc/folders_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/complete_tasks/view/complete_tasks_view.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/view/user_tasks_folders_view.dart';
import 'package:maine_app/feauters/thems/view/thems_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ProfileView(),
    ThemsWidgetsView(),
    const CompleteTasksView(),
    const UserTasksFolders(),
  ];

  void _onTabTappedInit(int index, TasksTreesBloc initBloc) {
    setState(() {
      _currentIndex = index;
      initBloc.add(ShowTasksTreesEvent());
    });
  }

  void _onTabTappedReload(int index, TasksTreesBloc reloadedBloc) {
    setState(() {
      _currentIndex = index;
      reloadedBloc.add(ReloadStatisticRootEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserTheme theme = GetIt.I.get<UserTheme>();
    final String backgroundImagePath = theme.imagePath; // Фон по умолчанию

    return MultiBlocProvider(
      providers: [
        BlocProvider<FoldersBloc>(
          create: (context) => FoldersBloc(),
        ),
        BlocProvider<TasksTreesBloc>(
          create: (context) => TasksTreesBloc(),
        ),
      ],
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: backgroundImagePath.startsWith('assets/')
                  ? AssetImage(backgroundImagePath) as ImageProvider
                  : FileImage(File(backgroundImagePath)),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: IndexedStack(
                  index: _currentIndex,
                  children: _screens,
                ),
              ),
              CustomBottomNavigationBar(
                currentIndex: _currentIndex,
                onInit: _onTabTappedInit,
                onReload: _onTabTappedReload,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
