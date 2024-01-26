import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/shared/cubit/cubit.dart';
import 'package:task1/shared/cubit/states.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppState>(
            builder: (context, state) {
              return  Scaffold(
                  body: Padding(
                padding:const EdgeInsets.only(left:15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                            "Latest News",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w200),
                          ),
                            const Spacer(),
                            IconButton(
                              icon:const Icon(Icons.arrow_circle_right_outlined,weight:10,),
                              onPressed: () {},
                            ),
                      ],
                    )
                  ],
                ),
              ));
            },
            listener: (context, state) {}));
  }
}
