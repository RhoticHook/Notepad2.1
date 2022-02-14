import 'package:bloc/bloc.dart';
import 'package:delete_mee/model/FirstListModel.dart';
import 'package:meta/meta.dart';

part 'creator_state.dart';

class CreatorCubit extends Cubit<CreatorState> {
  CreatorCubit() : super(CreatorInitial());
}
