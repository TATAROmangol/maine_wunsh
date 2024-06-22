import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:maine_app/domain/repository.dart';
import 'package:maine_app/domain/repository_models/realm_models.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/root_task_bloc/root_task_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/subtask_bloc/subtask_bloc.dart';

class ChangeChildrenTasksOrderButton extends StatefulWidget {
  const ChangeChildrenTasksOrderButton({
    required this.task,
    required this.currentBloc,
    super.key,
  });

  final Task task;
  final Bloc currentBloc;

  @override
  ChangeChildrenTasksOrderButtonState createState() =>
      ChangeChildrenTasksOrderButtonState();
}

class ChangeChildrenTasksOrderButtonState
    extends State<ChangeChildrenTasksOrderButton> {
  final UserTheme theme = GetIt.I.get<UserTheme>();
  final Repository repository = GetIt.I.get<Repository>();

  @override
  Widget build(BuildContext context) {
  final taskData = repository.getNotification(widget.task.uid.hashCode);

    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      child: SizedBox(
        width: screenSize.height * 0.04,
        height: screenSize.height * 0.04,
        child: Center(
          child: Image.asset(
            'assets/icons/order.png',
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
              title: const Text('Изменить порядок'),
              backgroundColor: theme.accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
                side: BorderSide(color: theme.borderColor, width: 2.0),
              ),
              content: SizedBox(
                height: screenSize.height * 0.6,
                width: screenSize.width * 0.9,
                child: ReorderableListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final task = widget.currentBloc.state.children[index];
                    return Container(
                      decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: theme.blocsColor,
                            border: Border(
                              left: BorderSide(
                                color: theme.borderColor,
                                width: 1.0,
                              ),
                              right: BorderSide(
                                color: theme.borderColor,
                                width: 2.0,
                              ),
                              bottom: BorderSide(
                                color: theme.borderColor,
                                width: 2.0,
                              ),
                              top: BorderSide(
                                color: theme.borderColor,
                                width: 1.0,
                              ),
                            ),
                          ),
                      height: screenSize.height * 0.09,
                      width: screenSize.width * 0.87,
                      margin:
                          EdgeInsets.only(bottom: screenSize.height * 0.013),
                      key: ValueKey(task.uid),
                      child: Padding(
                                padding: EdgeInsets.only(left: screenSize.width * 0.05, right: screenSize.width * 0.05),
                                child: Center( child: Row(
                                  children: [
                                    Text(task.name),
                                    const Spacer(),
                                    if(taskData != null)
                                      Text(DateFormat('dd-MM-yyyy').format(taskData.scheduledDate!))
                                  ],),),),
                    );
                  },
                  itemCount: widget.currentBloc.state.children.length,
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final Task topTask =
                        widget.currentBloc.state.children.removeAt(oldIndex);
                    widget.currentBloc.state.children.insert(newIndex, topTask);
                  },
                  proxyDecorator:
                      (Widget child, int index, Animation<double> animation) {
                    return Material(
                      color: Colors.transparent,
                      child: child,
                    );
                  },
                ),
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
                      if (widget.currentBloc is RootTaskBloc) {
                        widget.currentBloc.add(
                          EndChangeRootTaskOrderChildrenEvent(
                            children: widget.currentBloc.state.children,
                            parentUid: widget.task.uid,
                          ),
                        );
                      } else {
                        widget.currentBloc.add(
                          EndChangeSubtaskOrderChildrenEvent(
                            children: widget.currentBloc.state.children,
                            parentUid: widget.task.uid,
                          ),
                        );
                      }
                      Navigator.of(context).pop();
                    },
                  child: const Text('Изменить'),
                  )
              ],
            );
          },
        );
      },
    );
  }
}
