import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/repository.dart';
import 'package:maine_app/domain/repository_models/realm_models.dart';

part 'folders_event.dart';
part 'folders_state.dart';

class FoldersBloc extends Bloc<FoldersEvent, FoldersState> {
  FoldersBloc() : super(FoldersInitial()) {
    on<ShowFoldersEvent>((event, emit) async {
      final folders = await repository.getFolders();
      final activeFolder = await repository.getActiveFolder();
      emit(ShowFoldersState(folders: folders, activeFolder: activeFolder));
    });

    on<ChangeOrderFolderEvent>((event, emit) {
      for (var i = 0; i < event.folders.length; i++) {
        repository.updateFolderOrder(
            event.folders[i], event.folders.length - i - 1);
      }
      add(ShowFoldersEvent());
    });

    on<AddFolderEvent>((event, emit) async {
      await repository.addFolder(event.name);
      add(ShowFoldersEvent());
    });

    on<ChangeActiveFolder>((event, emit) async {
      repository.changeActiveFolder(event.folder);
      add(ShowFoldersEvent());
    });

    on<DeleteActiveFolderEvent>((event, emit) async {
      await repository.deleteActiveFolder();
      add(ShowFoldersEvent());
    });

    on<RenameActiveFolderEvent>((event, emit) async {
      repository.renameActiveFolder(event.name);
      add(ShowFoldersEvent());
    });
  }

  final Repository repository = GetIt.I.get<Repository>();
}
