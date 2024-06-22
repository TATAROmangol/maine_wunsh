part of 'folders_bloc.dart';

class FoldersEvent {}

class ShowFoldersEvent extends FoldersEvent {}

class AddFolderEvent extends FoldersEvent {
  AddFolderEvent({required this.name});
  final String name;
}

class DeleteActiveFolderEvent extends FoldersEvent {
}

class RenameActiveFolderEvent extends FoldersEvent {
  RenameActiveFolderEvent({required this.name});
  final String name;
}

class ChangeOrderFolderEvent extends FoldersEvent {
  ChangeOrderFolderEvent({required this.folders});

  final List<Folder> folders;
}

class ChangeActiveFolder extends FoldersEvent {
  ChangeActiveFolder({required this.folder});
  final Folder folder;
}
