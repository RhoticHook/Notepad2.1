part of 'creator_bloc.dart';

@immutable
abstract class CreatorEvent {}

class GetList extends CreatorEvent {
  FirstListModel oneElement;

  GetList(this.oneElement);
}
