import 'package:delete_mee/model/first_list_mode.dart';

abstract class FirstListRepository {
  Future<bool> addElement(FirstListModel? e);
  Future<bool> addAllList(List<FirstListModel>? list);
  Future<void> deleteElement(String id);
  Future<bool> clean();
  Future<List<FirstListModel>> getList();
  Future<FirstListModel> getElement(String? id);
  Future<FirstListModel> removeAtId(String id);
  Future<bool> noEmpty();
  Future<void> deleteLastElement();
}

class MockFirstListRepository with FirstListRepository {
  List<FirstListModel> firstList = [];

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
    await Future.delayed(const Duration(seconds: 3));
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
  Future<void> deleteLastElement() async {
    firstList.removeLast();
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
