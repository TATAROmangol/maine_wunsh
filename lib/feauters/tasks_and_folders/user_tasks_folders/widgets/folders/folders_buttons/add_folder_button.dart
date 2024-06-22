import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/folders_bloc/folders_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';

class AddFolderButton extends StatefulWidget {
  const AddFolderButton({super.key});

  @override
  AddFolderButtonState createState() => AddFolderButtonState();
}

class AddFolderButtonState extends State<AddFolderButton> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
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
    final UserTheme theme = GetIt.I.get<UserTheme>();
    final Size screenSize = MediaQuery.of(context).size;
    final foldersBloc = BlocProvider.of<FoldersBloc>(context);
    final tasksTreeBloc = BlocProvider.of<TasksTreesBloc>(context);

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
            'assets/icons/add_category.png',
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
              title: const Text('Добавить папку'),
              backgroundColor: theme.accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
                side: BorderSide(color: theme.borderColor, width: 2.0),
              ),
              content: TextField(
                        controller: textController,
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
                        maxLines: null,
                        minLines: 3,
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
                    String itemName = textController.text;
                    if (itemName.isNotEmpty) {
                      foldersBloc.add(AddFolderEvent(name: itemName));
                      foldersBloc.stream.listen((state) {
                        if (state is ShowFoldersState) {
                          tasksTreeBloc.add(ShowTasksTreesEvent());
                        }
                      });
                    }
                    textController.clear();
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
