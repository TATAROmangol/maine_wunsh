import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/folders_bloc/folders_bloc.dart';

class RenameActiveFolderButton extends StatefulWidget {
  const RenameActiveFolderButton({required this.currentName, super.key});

  final String currentName;

  @override
  RenameActiveFolderButtonState createState() =>
      RenameActiveFolderButtonState();
}

class RenameActiveFolderButtonState extends State<RenameActiveFolderButton> {
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
    final TextEditingController textController =
        TextEditingController(text: widget.currentName);
    final foldersBloc = BlocProvider.of<FoldersBloc>(context);

    return GestureDetector(
      child: SizedBox(
        height: screenSize.height * 0.04,
        width: screenSize.height * 0.04,
        child: Center(
          child: Image.asset(
            'assets/icons/redact.png',
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
              title: const Text('Переименовать папку'),
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
                    if (itemName != widget.currentName) {
                      foldersBloc.add(RenameActiveFolderEvent(name: itemName));
                    }

                    textController.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Переименовать'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
