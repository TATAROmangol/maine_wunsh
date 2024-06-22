part of 'folders_bloc.dart';

class FoldersState {}

class FoldersInitial extends FoldersState {
  final List<Folder> foldersNavigation = [];
}

class ShowFoldersState extends FoldersState {
  ShowFoldersState({required this.folders, required this.activeFolder});

  final List<Folder> folders;
  final Folder? activeFolder;
}
