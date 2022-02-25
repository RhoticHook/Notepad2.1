import 'package:bloc/bloc.dart';
import 'package:delete_mee/model/first_list_model.dart';
import 'package:meta/meta.dart';

import '../../first_list_repository.dart';

part 'creator_event.dart';
part 'creator_state.dart';

class CreatorBloc extends Bloc<CreatorEvent, CreatorState> {
  final FirstListRepository _fakeRepository;

  CreatorBloc(this._fakeRepository) : super(const CreatorInitial()) {
    on<GetList>((event, emit) async {
      try {
        emit(const CreatorLoading());
        await _fakeRepository.addElement(event.oneElement);
        var list = await _fakeRepository.getList();
        emit(CreatorLoaded(list));
      } on Exception catch (_) {
        emit(const CreatorError("error 404!, page not found"));
      }
    });
  }
}
