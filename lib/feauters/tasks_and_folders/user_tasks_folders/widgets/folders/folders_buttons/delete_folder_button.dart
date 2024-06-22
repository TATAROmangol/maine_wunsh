import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/folders_bloc/folders_bloc.dart';

class DeleteActiveFolderButton extends StatefulWidget {
  const DeleteActiveFolderButton({required this.currentBloc, super.key});

  final Bloc currentBloc;

  @override
  DeleteActiveFolderButtonState createState() =>
      DeleteActiveFolderButtonState();
}

class DeleteActiveFolderButtonState extends State<DeleteActiveFolderButton> {

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final UserTheme theme = GetIt.I.get<UserTheme>();
    return GestureDetector(
      child: SizedBox(
        height: screenSize.height * 0.04,
        width: screenSize.height * 0.04,
        child: Center(
          child: Image.asset(
            'assets/icons/delete.png',
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
                title: const Text('Вы уверенны?'),
                backgroundColor: theme.accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
                side: BorderSide(color: theme.borderColor, width: 2.0),
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
                      widget.currentBloc.add(DeleteActiveFolderEvent());
                      Navigator.of(context).pop();
                    },
                    child: const Text('Удалить'),
                  ),
                ],
              );
            },
          );
        },);
  }
}
