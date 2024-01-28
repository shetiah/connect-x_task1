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
                    myImage(urlToImage: 'assets/icons/sports.png', ctg: 'sports', context: context),
                   const SizedBox(height:14),
                     myImage(urlToImage: 'assets/icons/science.avif', ctg: 'science', context: context),
                     const SizedBox(height:14),
                       myImage(urlToImage: 'assets/icons/buisness.png', ctg: 'business', context: context),
                  ],
                ),
               const SizedBox(width:20),
                Column(
                  children: [  
                    myImage(urlToImage: 'assets/icons/sports.png', ctg: 'sports', context: context),
                   const SizedBox(height:14),
                     myImage(urlToImage: 'assets/icons/science.avif', ctg: 'science', context: context),
                     const SizedBox(height:14),
                       myImage(urlToImage: 'assets/icons/buisness.png', ctg: 'business', context: context),
                       
                  
                  ],
                )
                          ],
                        ),
              ],
            ));
      },
      listener: (context, state) {},
    );
  }
}