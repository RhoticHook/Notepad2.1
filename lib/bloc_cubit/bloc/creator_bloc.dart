import 'package:bloc/bloc.dart';
import 'package:delete_mee/model/first_list_model.dart';
import 'package:meta/meta.dart';

import '../../first_list_repository.dart';

part 'creator_event.dart';
part 'creator_state.dart';

class CreatorBloc extends Bloc<CreatorEvent, CreatorState> {
  final FirstListRepository _fakeRepository;

  CreatorBloc(this._fakeRepository) : super(const CreatorInitial());
  // {
  //   on<CreatorEvent>((event, emit) {
  //     // TODO: implement event handler
  //   });
  // }

  @override
  Stream<CreatorState> mapEventToState(
    CreatorEvent event,
  ) async* {
    if (event is GetList) {
      try {
        yield const CreatorLoading();
        await _fakeRepository.addElement(event.oneElement);
        var list = await _fakeRepository.getList();
        yield CreatorLoaded(list);
      } on Exception catch (_) {
        yield const CreatorError("error 404!, page not found");
      }
    }
  }
}
