import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';

class ChangeTreesOrderButton extends StatefulWidget {
  const ChangeTreesOrderButton({required this.tasksTreesBloc, super.key});

  final TasksTreesBloc tasksTreesBloc;

  @override
  ChangeTreesOrderButtonState createState() => ChangeTreesOrderButtonState();
}

class ChangeTreesOrderButtonState extends State<ChangeTreesOrderButton> {
  final UserTheme theme = GetIt.I.get<UserTheme>();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return BlocBuilder<TasksTreesBloc, TasksTreesState>(
      bloc: widget.tasksTreesBloc,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            (state is ShowTasksTreesState && state.changeOrder)
                ? widget.tasksTreesBloc.add(ShowTasksTreesEvent())
                : widget.tasksTreesBloc
                    .add(ShowTasksTreesEvent(changeOrder: true));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: theme.accentColor,
            ),
            height: screenSize.height * 0.045,
            width: screenSize.height * 0.045,
            margin: const EdgeInsets.only(bottom: 5),
            child: Center(
                child: Image.asset(
              (state is ShowTasksTreesState && state.changeOrder)
                  ? 'assets/icons/stop.png'
                  : 'assets/icons/order.png',
              width: screenSize.height * 0.035,
              height: screenSize.height * 0.035,
              fit: BoxFit.contain,
            )),
          ),
        );
      },
    );
  }
}
