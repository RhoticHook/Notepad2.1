import 'package:delete_mee/blocCubit/cubit/creator_cubit.dart';
import 'package:delete_mee/screens/firstPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/list_xd_bloc.dart';
import 'firstListRepository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FirstListRepository repo;
  @override
  void initState() {
    repo = MockFirstListRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter notepad',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: FirstPage(),
      home: BlocProvider(
        create: (context) => CreatorCubit(MockFirstListRepository()),
        child: FirstPage(),
      ),
    );
  }
}
