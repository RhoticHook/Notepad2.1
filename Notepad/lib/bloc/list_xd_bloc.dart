// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// import '../firstListRepository.dart';

// part 'list_xd_event.dart';
// part 'list_xd_state.dart';

// class ListXdBloc extends Bloc<ListXdEvent, ListXdState> {
//   FirstListRepository repo;
//   ListXdBloc(this.repo) : super(ListXdInitial()) {
//     on<ListXdEvent>((event, emit) {
//       repo.addElement(e);
//       emit(JakisState(repo.firstList));
//     });
//   }
// }

// JakisState{
//   List<FirstList> lsitxd12;
// }