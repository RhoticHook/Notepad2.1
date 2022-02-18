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
  //first i had 'o' but i need to change it to 'other' why?
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreatorError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
