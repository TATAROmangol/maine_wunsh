import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/profile/widgets/learn.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';

import '../widgets/log_out_widget.dart';
import '../widgets/profile_widget.dart';
import '../widgets/progress_bars/progress_bars_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final listenBloc = BlocProvider.of<TasksTreesBloc>(context);
    final UserTheme theme = GetIt.I.get<UserTheme>();
    return BlocProvider(
      create: (context) => TasksTreesBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Мой профиль', style: TextStyle(color: theme.textColor))),
          backgroundColor: theme.accentColor,
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        ),
        body: Column(
          children: [
            Spacer(),
            const ProfileWidget(),
            Spacer(),
            ProgressBarsWidget(listenBloc: listenBloc),
            Spacer(),
            LogOutWidget(),
            Spacer(),
            TutorialButton(),
            Spacer(),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
