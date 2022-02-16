import 'package:delete_mee/model/first_list_model.dart';

abstract class FirstListRepository {
  Future<bool> addElement(FirstListModel? e);
  Future<void> deleteElement(String id);
  Future<List<FirstListModel>> getList();
  Future<FirstListModel> getElement(String? id);
}

class MockFirstListRepository with FirstListRepository {
  List<FirstListModel> firstList = [];

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
