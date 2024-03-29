import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/shared/components/components/my_main_components.dart';
import 'package:task1/shared/cubit/cubit.dart';
import 'package:task1/shared/cubit/states.dart';

class MyNewsPage extends StatelessWidget {
  const MyNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
            body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        myImage(
                          textname: 'SPORT',
                          txtColor: Colors.white,
                          color: Colors.blue,
                            urlToImage: 'assets/icons/sports.png',
                            ctg: 'sports',
                            context: context),
                      
                      ],
                    ),
                    const SizedBox(height: 14),
                    myImage(
                       textname: 'SCIENCE',
                       txtColor: Colors.white,
                      color:Colors.blueGrey,
                        urlToImage: 'assets/icons/science.avif',
                        ctg: 'science',
                        context: context),
                    const SizedBox(height: 14),
                    myImage(
                       textname: 'BUISNESS',
                       txtColor:Color.fromARGB(255, 100, 159, 208),
                      color: Colors.brown,
                        urlToImage: 'assets/icons/buisness.png',
                        ctg: 'business',
                        context: context),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    myImage(
                       textname: 'FUN',
                       txtColor: Colors.black,
                       color: Colors.yellow,
                        urlToImage: 'assets/icons/entertainment.jpeg',
                        ctg: 'entertainment',
                        context: context),
                    const SizedBox(height: 14),
                    myImage(
                       textname: 'TECH',
                       txtColor: Color.fromARGB(255, 29, 68, 99),
                       color:Colors.lightBlue,
                        urlToImage: 'assets/icons/technology.jpg',
                        ctg: 'technology',
                        context: context),
                    const SizedBox(height: 14),
                    myImage(
                       textname: 'HEALTH',
                       txtColor: Colors.white,
                       color: Colors.green,
                        urlToImage: 'assets/icons/health.avif',
                        ctg: 'health',
                        context: context),
                  ],
                )
              ],
            ),
             SizedBox(
              height:cubit.getScreenHeight(context)*.08
             )
          ],
        ));
      },
      listener: (context, state) {},
    );
  }
}
