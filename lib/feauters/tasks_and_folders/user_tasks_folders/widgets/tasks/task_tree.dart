import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maine_app/domain/repository_models/realm_models.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/root_task_bloc/root_task_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/widgets/tasks/root_task_widget.dart';

class TaskTreeView extends StatefulWidget {
  const TaskTreeView({super.key});

  @override
  TaskTreeViewState createState() => TaskTreeViewState();
}

class TaskTreeViewState extends State<TaskTreeView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TasksTreesBloc>(context).add(ShowTasksTreesEvent());
  }

  List<Widget> getRootTasksWidgets(
      ShowTasksTreesState state, TasksTreesBloc tasksTreesBloc) {
    return state.children.map(
      (e) {
        var isActive = state.activeChildUid == e.uid;
        var parentUid = state.parentUid;
        return BlocProvider<RootTaskBloc>(
          key: ValueKey(e.uid),
          create: (context) => RootTaskBloc(),
          child: BlocBuilder<RootTaskBloc, RootTaskState>(
            key: ValueKey(e.uid),
            builder: (context, state) {
              return RootTaskWidget(
                task: e,
                parentUid: parentUid,
                isActive: isActive,
                currentBloc: BlocProvider.of<RootTaskBloc>(context),
                parentBloc: tasksTreesBloc,
              );
            },
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final tasksTreesBloc = BlocProvider.of<TasksTreesBloc>(context);

    return BlocBuilder<TasksTreesBloc, TasksTreesState>(
      bloc: tasksTreesBloc,
      builder: (context, state) {
        if (state is ShowTasksTreesState) {
          final children = getRootTasksWidgets(state, tasksTreesBloc);
          return Flexible(
            child: state.activeChildUid == '' && state.changeOrder
                ? ReorderableListView.builder(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return children[index];
                    },
                    itemCount: state.children.length,
                    onReorder: (oldIndex, newIndex) {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final Task topTask = state.children.removeAt(oldIndex);
                      state.children.insert(newIndex, topTask);

                      tasksTreesBloc.add(
                          ChangeOrderTasksTreesEvent(children: state.children));
                    },
                    proxyDecorator:
                        (Widget child, int index, Animation<double> animation) {
                      return Material(
                        color: Colors.transparent,
                        child: child,
                      );
                    },
                  )
                : ListView(children: children),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
