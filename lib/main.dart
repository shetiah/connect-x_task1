import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/modules/HomePage.dart';
import 'package:task1/shared/cubit/blocobserver.dart';
import 'package:task1/shared/cubit/cubit.dart';
import 'package:task1/shared/cubit/states.dart';
import 'package:task1/shared/network/remote/dioHelper.dart';

void main()  {
  Bloc.observer = MyBlocObserver();

  DioHelper.init();

  runApp(const AppMain());
}

class AppMain extends StatelessWidget {
  const AppMain({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppState>(
            builder: (context, state) {
              return  MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(icon:const Icon(Icons.menu), onPressed: () {  }, ),
                    title: Text("NewsApp"),
                    actions: [IconButton(icon:const Icon(Icons.mic), onPressed: () {  }, ),],

                  ),
                ),
              );
            }, listener: (context, state) {}));
  }
}
