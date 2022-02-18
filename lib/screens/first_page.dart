import 'package:delete_mee/blocCubit/cubit/creator_cubit.dart';
import 'package:delete_mee/first_list_repository.dart';
import 'package:delete_mee/model/first_list_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  MockFirstListRepository fakeFirebase = MockFirstListRepository();
  int iterableNameForWidgets = 0;
  var uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final creatorCubit = context.read<CreatorCubit>();
          _addWidget(creatorCubit);
        },
      ),
      appBar: AppBar(
        title: const Text("Notepad M"),
      ),
      body: Center(
        child: BlocConsumer<CreatorCubit, CreatorState>(
          listener: (context, state) {
            if (state is CreatorError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          },
          builder: (context, state) {
            if (state is CreatorInitial) {
              return _emptyCase();
            } else if (state is CreatorLoaded) {
              fakeFirebase.firstList = state
                  .firstList!; //this is veary bad, it should be only one list from fake repository!!!
              if (state.firstList?.isNotEmpty == true) {
                return ReorderableListView.builder(
                  onReorder: (oldIndex, newIndex) async {
                    final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
                    final oneElement =
                        fakeFirebase.firstList.removeAt(oldIndex);
                    fakeFirebase.firstList.insert(index, oneElement);
                    setState(() {});
                  },
                  itemCount: state.firstList!.length,
                  itemBuilder: (context, index) {
                    return _buildPlate(state.firstList!, index);
                  },
                );
              } else {
                return _emptyCase();
              }
            } else {
              return const CircularProgressIndicator(
                color: Colors.yellow,
              );
            }
          },
        ),
      ),
    );
  }

  Widget _emptyCase() {
    return Center(child: Lottie.asset('assets/lottie/emptyApp.json'));
  }

  ListTile _buildPlate(List<FirstListModel> snapshot, int index) {
    return ListTile(
      key: ValueKey(snapshot[index].id),
      title: Text(snapshot[index].text),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              _remove(index);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () => _edit(snapshot[index].id),
            icon: const Icon(
              Icons.edit,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  void _edit(String id) => showDialog(
        context: context,
        builder: (context) {
          return FutureBuilder(
            future: fakeFirebase.getElement(id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return AlertDialog(
                content: TextFormField(
                    textInputAction: TextInputAction.go,
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

  void _remove(int index) {
    var e = fakeFirebase.firstList[index];
    setState(() {
      fakeFirebase.deleteElement(e.id);
    });
  }

  void _addWidget(CreatorCubit creatorCubit) {
    setState(() {});
    var vId = uuid.v1();
    final item =
        FirstListModel(text: iterableNameForWidgets.toString(), id: vId);
    iterableNameForWidgets++;
    creatorCubit.getList(item);
  }
}
