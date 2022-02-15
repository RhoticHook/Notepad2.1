part of 'creator_cubit.dart';

@immutable
abstract class CreatorState {
  const CreatorState();
}

class CreatorInitial extends CreatorState {
  const CreatorInitial();
}

class CreatorLoading extends CreatorState {
  const CreatorLoading();
}

// ignore: must_be_immutable
class CreatorLoaded extends CreatorState {
  List<FirstListModel>? firstList;

  CreatorLoaded(this.firstList);
}

class CreatorError extends CreatorState {
  final String message;
  const CreatorError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CreatorError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
