import 'package:bloc/bloc.dart';
import 'package:delete_mee/firstListRepository.dart';
import 'package:delete_mee/model/FirstListModel.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';

part 'creator_state.dart';

class CreatorCubit extends Cubit<CreatorState> {
  final FirstListRepository _fakeRepository;

  CreatorCubit(this._fakeRepository) : super(const CreatorInitial());

  Future<void> getList(FirstListModel oneElement) async {
    try {
      emit(const CreatorLoading());
      await _fakeRepository.addElement(oneElement);
      var list = await _fakeRepository.getList();
      emit(CreatorLoaded(list));
    } on Exception catch (_) {
      emit(const CreatorError("error 404!, page not found, lol"));
    }
  }
}
