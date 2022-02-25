part of 'creator_bloc.dart';

@immutable
abstract class CreatorEvent {}

// ignore: must_be_immutable
class GetList extends CreatorEvent {
  FirstListModel oneElement;

  GetList(this.oneElement);
}
