import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'creator_event.dart';
part 'creator_state.dart';

class CreatorBloc extends Bloc<CreatorEvent, CreatorState> {
  CreatorBloc() : super(CreatorInitial()) {
    on<CreatorEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
