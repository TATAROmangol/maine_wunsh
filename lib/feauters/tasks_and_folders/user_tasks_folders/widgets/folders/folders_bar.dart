import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/repository_models/realm_models.dart';
import 'package:maine_app/domain/user_theme.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/folders_bloc/folders_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';
import 'package:maine_app/feauters/tasks_and_folders/user_tasks_folders/widgets/folders/folder_widget.dart';

class FolderBar extends StatefulWidget {
  const FolderBar({super.key});

  @override
  FolderBarState createState() => FolderBarState();
}

class FolderBarState extends State<FolderBar> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FoldersBloc>(context).add(ShowFoldersEvent());
  }

  @override
  Widget build(BuildContext context) {
    final UserTheme theme = GetIt.I.get<UserTheme>();
    final Size screenSize = MediaQuery.of(context).size;
    final FoldersBloc foldersBloc = BlocProvider.of<FoldersBloc>(context);
    final TasksTreesBloc tasksTreesBloc =
        BlocProvider.of<TasksTreesBloc>(context);

    return BlocBuilder<FoldersBloc, FoldersState>(builder: (context, state) {
      if (state is ShowFoldersState) {
        final folders = state.folders;
        return Stack(
          children: [
            Container(
              height: screenSize.height * 0.05,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: theme.borderColor,
                    width: 1,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: screenSize.height * 0.016),
              height: screenSize.height * 0.05,
              child: ReorderableListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final folder = folders[index];
                  final isActive = state.activeFolder == null
                      ? false
                      : state.activeFolder == folder;
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: foldersBloc),
                      BlocProvider.value(value: tasksTreesBloc),
                    ],
                    key: ValueKey(folder.uid),
                    child: FolderWidget(
                        folder: folder,
                        isActive: isActive,
                        last: index == folders.length - 1),
                  );
                },
                itemCount: folders.length,
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final Folder folderNavigation = folders.removeAt(oldIndex);
                  folders.insert(newIndex, folderNavigation);

                  foldersBloc.add(ChangeOrderFolderEvent(folders: folders));
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
          ],
        );
      }
      return const Text('Загрузка...');
    });
  }
}
