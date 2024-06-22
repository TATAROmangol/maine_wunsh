import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/repository_models/realm_models.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/folders_bloc/folders_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/widgets/folders/folders_buttons/delete_folder_button.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/widgets/folders/folders_buttons/rename_folder_button.dart';

class FolderWidget extends StatefulWidget {
  const FolderWidget({
    super.key,
    required this.folder,
    required this.last,
    required this.isActive,
  });

  final Folder folder;
  final bool isActive;
  final bool last;

  @override
  FolderWidgetState createState() => FolderWidgetState();
}

class FolderWidgetState extends State<FolderWidget> {
  bool showButtons = false;

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
    final secondColor = transformColor(theme.accentColor);
    final Size screenSize = MediaQuery.of(context).size;
    final foldersBloc = BlocProvider.of<FoldersBloc>(context);
    final tasksTreeBloc = BlocProvider.of<TasksTreesBloc>(context);
    if (!widget.isActive) {
      showButtons = false;
    }
    return BlocListener<FoldersBloc, FoldersState>(
      bloc: foldersBloc,
      listener: (context, state) {
        if (state is ShowFoldersState) {
          showButtons = false;
        }
      },
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0) {
            if (widget.isActive) {
              setState(() {
                showButtons = true;
              });
            }
          } else if (details.delta.dy < 0) {
            // свайп вверх
            setState(() {
              showButtons = false;
            });
          }
        },
        child: Container(
          constraints: BoxConstraints(
            minWidth: screenSize.width * 0.25,
          ),
          margin: const EdgeInsets.only(left: 3, right: 2),
          decoration: (widget.isActive)
              ? BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: theme.accentColor,
                  border: Border(
                    left: BorderSide(
                      color: theme.borderColor,
                      width: 1,
                    ),
                    right: BorderSide(
                      color: theme.borderColor,
                      width: 1.5,
                    ),
                    bottom: BorderSide(
                      color: theme.borderColor,
                      width: 1.5,
                    ),
                  ),
                )
              : BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: secondColor,
                  border: Border(
                    top: BorderSide(
                      color: theme.borderColor,
                      width: 1,
                    ),
                    left: BorderSide(
                      color: theme.borderColor,
                      width: 1,
                    ),
                    right: BorderSide(
                      color: theme.borderColor,
                      width: 1,
                    ),
                    bottom: BorderSide(
                      color: theme.borderColor,
                      width: 1,
                    ),
                  ),
                ),
          child: SizedBox(
            child: showButtons
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RenameActiveFolderButton(currentName: widget.folder.name),
                      DeleteActiveFolderButton(currentBloc: foldersBloc)
                    ],
                  )
                : TextButton(
                    onPressed: () {
                      if (!widget.isActive) {
                        foldersBloc
                            .add(ChangeActiveFolder(folder: widget.folder));
                        foldersBloc.stream.listen((state) {
                          if (state is ShowFoldersState) {
                            tasksTreeBloc
                                .add(ShowTasksTreesEvent(activeChildUid: ''));
                          }
                        });
                      }
                    },
                    child: Center(child: Text(widget.folder.name)),
                  ),
          ),
        ),
      ),
    );
  }
}
