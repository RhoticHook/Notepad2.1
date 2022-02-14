//https://pastebin.com/3rYKTRVH
import 'package:delete_mee/bloc/list_xd_bloc.dart';
import 'package:delete_mee/firstListRepository.dart';
import 'package:delete_mee/model/FirstListModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key? key}) : super(key: key);
  int lol = -1;
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  MockFirstListRepository fakeFirebase = MockFirstListRepository();
  //List<FirstListModel> firstList = [];
  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addWidget,
      ),
      appBar: AppBar(
        title: const Text("Notepad M"),
      ),
      body: Center(
          child: fakeFirebase.firstList.isNotEmpty
              ? FutureBuilder<List<FirstListModel>>(
                  future: fakeFirebase.getList(),
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? ReorderableListView.builder(
                            onReorder: (oldIndex, newIndex) async {
                              final index =
                                  newIndex > oldIndex ? newIndex - 1 : newIndex;
                              final oneElement =
                                  fakeFirebase.firstList.removeAt(oldIndex);
                              //oneElement.id = oldIndex.toString();
                              fakeFirebase.firstList
                                  .insert(index, await oneElement);
                              //fakeFirebase.editId(index.toString());

                              setState(() {});
                            },
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              if (snapshot.data?[index] != null) {
                                return ListTile(
                                  key: ValueKey(snapshot.data![index].id),
                                  title: Text(snapshot.data![index].text),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          remove(index);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            edit(snapshot.data![index].id),
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          )
                        : const CircularProgressIndicator();
                  },
                )
              : const Text("I am empty")),
    );
  }

  // Widget buildPlate(FirstListModel oneElement, int index) {
  //   return ListTile(
  //     key: ValueKey(oneElement.id),
  //     title: Text(oneElement.text),
  //     trailing: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         IconButton(
  //           onPressed: () {
  //             remove(index);
  //           },
  //           icon: const Icon(
  //             Icons.delete,
  //             color: Colors.black,
  //           ),
  //         ),
  //         IconButton(
  //           onPressed: () => edit(oneElement.id),
  //           icon: const Icon(
  //             Icons.edit,
  //             color: Colors.black,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  void edit(String id) => showDialog(
        context: context,
        builder: (context) {
          return FutureBuilder(
            future: fakeFirebase.getElement(id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return AlertDialog(
                content: TextFormField(
                    initialValue:
                        snapshot.data == null ? "" : snapshot.data.text,
                    onChanged: (text) {
                      setState(() {
                        snapshot.data.text = text;
                      });
                    }),
              );
            },
          );
        },
      );

  void remove(int index) {
    var e = fakeFirebase.firstList[index];
    if (e != null) {
      setState(() {
        fakeFirebase.deleteElement(e.id);
      });
    }
  }

  void _addWidget() {
    var vId = uuid.v1();
    widget.lol++;
    final item = FirstListModel(text: widget.lol.toString(), id: vId);
    setState(() {
      fakeFirebase.addElement(item);
    });
  }
}
