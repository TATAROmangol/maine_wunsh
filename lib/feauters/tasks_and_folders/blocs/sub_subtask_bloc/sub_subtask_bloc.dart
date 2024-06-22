import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/repository.dart';

part 'sub_subtask_event.dart';
part 'sub_subtask_state.dart';

class SubSubtaskBloc extends Bloc<SubSubtaskEvent, SubSubtaskState> {
  SubSubtaskBloc() : super(SubSubtaskStateInitial()) {
    on<ShowSubSubtaskEvent>((event, emit) async {
      emit(ShowSubSubtaskState());
    });
    on<CloseSubSubtaskEvent>((event, emit) async {
      emit(CloseSubSubtaskState());
    });
  }
  final Repository repository = GetIt.I.get<Repository>();
}
