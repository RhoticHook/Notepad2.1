import 'package:delete_mee/blocCubit/cubit/creator_cubit.dart';
import 'package:delete_mee/model/FirstListModel.dart';

abstract class FirstListRepository {
  List<FirstListModel> firstList = [];
  Future<bool> addElement(FirstListModel? e);
  Future<bool> addAllList(List<FirstListModel>? list);
  Future<void> deleteElement(String id);
  Future<bool> clean();
  Future<List<FirstListModel>> getList();
  Future<FirstListModel> getElement(String? id);
  Future<FirstListModel> removeAtId(String id);
  Future<bool> noEmpty();
}

class MockFirstListRepository with FirstListRepository {
  @override
  Future<bool> addAllList(List<FirstListModel>? list) async {
    if (list?.isNotEmpty == true) {
      firstList.addAll(list!);
      return true;
    }
    return false;
  }

  @override
  Future<bool> addElement(FirstListModel? e) async {
    if (e != null) {
      firstList.add(e);
      return true;
    }
    return false;
  }

  @override
  Future<bool> clean() async {
    firstList.clear();
    return true;
  }

  @override
  Future<FirstListModel> removeAtId(String id) async {
    return firstList.removeAt(int.parse(id));
  }

  @override
  Future<bool> noEmpty() async {
    return firstList.isNotEmpty;
  }

  @override
  Future<void> deleteElement(String id) async {
    firstList.removeWhere((element) => element.id == id);
    return;
  }

  @override
  Future<List<FirstListModel>> getList() async {
    return firstList;
  }

  @override
  Future<FirstListModel> getElement(String? id) async {
    return firstList.firstWhere((element) => element.id == id);
  }
}
