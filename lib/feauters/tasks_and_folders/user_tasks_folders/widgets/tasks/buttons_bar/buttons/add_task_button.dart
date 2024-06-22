import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/root_task_bloc/root_task_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/subtask_bloc/subtask_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/widgets/tasks/buttons_bar/buttons/data_text_controller.dart';

class AddChildTaskButton extends StatefulWidget {
  const AddChildTaskButton(
      {required this.currentBloc, required this.parentUid, super.key});

  final Bloc currentBloc;
  final String parentUid;

  @override
  AddChildTaskButtonState createState() => AddChildTaskButtonState();
}

class AddChildTaskButtonState extends State<AddChildTaskButton> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final UserTheme theme = GetIt.I.get<UserTheme>();
  DateTime? selectedDate;
  late final DataTextController dataTextController;

  Color transformColor(Color color) {
    int red = color.red;
    int green = color.green + 28;
    int blue = color.blue + 34;

    green = green.clamp(0, 255);
    blue = blue.clamp(0, 255);

    return Color.fromARGB(color.alpha, red, green, blue);
  }

  @override
  void initState() {
    super.initState();
    dataTextController = DataTextController('Выбрать дату');
  }

  @override
  void dispose() {
    nameController.dispose();
    commentController.dispose();
    dataTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      child: SizedBox(
        width: screenSize.height * 0.04,
        height: screenSize.height * 0.04,
        child: Center(
          child: Image.asset(
            'assets/icons/add_task.png',
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
              title: const Text('Добавить Задачу'),
              backgroundColor: theme.accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
                side: BorderSide(color: theme.borderColor, width: 2.0),
              ),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: screenSize.width * 0.8,
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Введите название',
                          filled: true,
                          fillColor: transformColor(theme.accentColor),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: theme.borderColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: theme.borderColor,
                              width: 2.0,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: theme.textColor,
                          ),
                        ),
                        style: TextStyle(color: theme.textColor),
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          labelText: 'Введите описание',
                          filled: true,
                          fillColor: transformColor(theme.accentColor),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: theme.borderColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: theme.borderColor,
                              width: 2.0,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: theme.textColor,
                          ),
                        ),
                        style: TextStyle(color: theme.textColor),
                        maxLines: null,
                        minLines: 3,
                      ),
                      const SizedBox(height: 10.0),
                      TextButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now().add(const Duration(days: 1)),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );

                          if (picked != null) {
                            setState(() {
                              selectedDate = DateTime(
                                  picked.year, picked.month, picked.day, 15, 00);
                                  
                            });
                            dataTextController.setText(
                                DateFormat('dd-MM-yyyy').format(selectedDate!));
                          }
                        },
                        child: ValueListenableBuilder<String>(
                          valueListenable: dataTextController.textNotifier,
                          builder: (context, buttonText, _) {
                            return Text(buttonText);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    nameController.clear();
                    commentController.clear();
                    setState(() {
                      selectedDate = null;
                    });
                    dataTextController.setText('Выбрать дату');
                    Navigator.of(context).pop();
                  },
                  child: const Text('Отмена'),
                ),
                ElevatedButton(
                  onPressed: () {
                    String taskName = nameController.text;
                    String taskComment = commentController.text;
                    if (taskName.isNotEmpty) {
                      widget.currentBloc is RootTaskBloc
                          ? widget.currentBloc.add(AddRootTaskChildEvent(
                              name: taskName,
                              comment: taskComment,
                              dateTime: selectedDate,
                              parentUid: widget.parentUid))
                          : widget.currentBloc.add(AddSubtaskChildEvent(
                              name: taskName,
                              comment: taskComment,
                              dateTime: selectedDate,
                              parentUid: widget.parentUid));
                    }
                    nameController.clear();
                    commentController.clear();
                    setState(() {
                      selectedDate = null;
                    });
                    dataTextController.setText('Выбрать дату');
                    Navigator.of(context).pop();
                  },
                  child: const Text('Добавить'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
