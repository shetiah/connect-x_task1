import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              var cubit = AppCubit.get(context);
              return  MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(icon:const Icon(Icons.menu), onPressed: () {  }, ),
                    title: const Text("NewsApp"),
                    actions: [IconButton(icon:const Icon(Icons.mic), onPressed: () {  }, ),],
                  
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    items: cubit.BottomNavItems,
                    currentIndex: cubit.bottomNavIndex,
                    onTap: (index) => cubit.changeIndex(index),
                    
                  ),
                  body: cubit.Screens[cubit.bottomNavIndex],
                ),
              );
            }, listener: (context, state) {}));
  }
}
