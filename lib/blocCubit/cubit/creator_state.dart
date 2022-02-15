part of 'creator_cubit.dart';

@immutable
abstract class CreatorState {
  const CreatorState();
}

class CreatorInitial extends CreatorState {
  const CreatorInitial();
}

class CreatorLoaded extends CreatorState {
  final FirstListModel firstList;
  const CreatorLoaded(this.firstList);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CreatorLoaded && o.firstList == firstList;
  }

  @override
  int get hashCode => firstList.hashCode;
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
