import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/widgets/tasks/buttons_bar/buttons/data_text_controller.dart';

class AddTasksTreeButton extends StatefulWidget {
  const AddTasksTreeButton({super.key});

  @override
  AddTasksTreeButtonState createState() => AddTasksTreeButtonState();
}

class AddTasksTreeButtonState extends State<AddTasksTreeButton> {
  final UserTheme theme = GetIt.I.get<UserTheme>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  DataTextController buttonTextController = DataTextController('Выбрать дату');
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    buttonTextController = DataTextController('Выбрать дату');
  }

  @override
  void dispose() {
    nameController.dispose();
    commentController.dispose();
    buttonTextController = DataTextController('Выбрать дату');
    super.dispose();
  }

  Color transformColor(Color color) {
    int red = color.red;
    int green = color.green + 28;
    int blue = color.blue + 34;

    green = green.clamp(0, 255);
    blue = blue.clamp(0, 255);

    return Color.fromARGB(color.alpha, red, green, blue);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TasksTreesBloc tasksTreeBloc =
        BlocProvider.of<TasksTreesBloc>(context);
    return GestureDetector(
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
            'assets/icons/add_task_tree.png',
            width: screenSize.height * 0.035,
            height: screenSize.height * 0.035,
            fit: BoxFit.contain,
          ),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Добавить Мечту'),
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
                            buttonTextController.setText(
                                DateFormat('dd-MM-yyyy').format(selectedDate!));
                          }
                        },
                        child: ValueListenableBuilder<String>(
                          valueListenable: buttonTextController.textNotifier,
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
                    buttonTextController = DataTextController('Выбрать дату');
                    selectedDate = null;
                    Navigator.of(context).pop();
                  },
                  child: const Text('Отмена'),
                ),
                ElevatedButton(
                  onPressed: () {
                    String taskName = nameController.text;
                    String taskComment = commentController.text;
                    if (taskName.isNotEmpty) {
                      tasksTreeBloc.add(AddTasksTreeEvent(
                          name: taskName,
                          comment: taskComment,
                          dateTime: selectedDate));
                    }
                    nameController.clear();
                    commentController.clear();
                    buttonTextController = DataTextController('Выбрать дату');
                    selectedDate = null;
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
