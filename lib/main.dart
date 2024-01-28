import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/shared/cubit/blocobserver.dart';
import 'package:task1/shared/cubit/cubit.dart';
import 'package:task1/shared/cubit/states.dart';
import 'package:task1/shared/network/remote/dioHelper.dart';

void main() {
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
        create: (BuildContext context) => AppCubit()..getInitalDataFromApis(),
         child: BlocConsumer<AppCubit, AppState>(
            builder: (context, state) {
              var cubit = AppCubit.get(context);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {},
                    ),
                    title: const Text("NewsApp"),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.mic),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  bottomNavigationBar: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: cubit.getScreenWidth(context) * .13,
                      vertical: cubit.getScreenWidth(context) * .07,
                    ),
                    height: cubit.getScreenWidth(context) * .155,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 30,
                          offset:const Offset(0, 10),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(50),
                    ),
                       child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: cubit.getScreenWidth(context) * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
                cubit.changeIndex(index);
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == cubit.bottomNavIndex
                      ? cubit.getScreenWidth(context) * .32
                      : cubit.getScreenWidth(context) * .18,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration:const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == cubit.bottomNavIndex ? cubit.getScreenWidth(context) * .12 : 0,
                    width: index == cubit.bottomNavIndex ? cubit.getScreenWidth(context) * .32 : 0,
                    decoration: BoxDecoration(
                      color: index == cubit.bottomNavIndex
                          ? const Color(0xFF3F92A4).withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == cubit.bottomNavIndex
                      ? cubit.getScreenWidth(context) * .31
                      : cubit.getScreenWidth(context) * .18,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == cubit.bottomNavIndex ? cubit.getScreenWidth(context) * .13 : 0,
                          ),
                          AnimatedOpacity(
                            opacity: index == cubit.bottomNavIndex ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              index == cubit.bottomNavIndex
                                  ? '${listOfStrings[index]}'
                                  : '',
                              style: const TextStyle(
                                color:Color(0xFF3F92A4),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration:const  Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == cubit.bottomNavIndex ? cubit.getScreenWidth(context) * .03 : 20,
                          ),
                          Icon(
                            listOfIcons[index],
                            size: cubit.getScreenWidth(context) * .076,
                            color: index == cubit.bottomNavIndex
                                ?const Color(0xFF3F92A4)
                                : Colors.black26,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
     
                  ),
                  body: cubit.screens[cubit.bottomNavIndex],
                ),
              );
            },
            listener: (context, state) {}));
            
  }
}
  List<IconData> listOfIcons = [
    Icons.article_outlined,
   Icons.newspaper_sharp,
   Icons.bookmark_add_rounded,
  ];

  List<String> listOfStrings = [
    'News',
    'MyNews',
    'Saved',
  ];