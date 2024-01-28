import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/shared/components/components/my_main_components.dart';
import 'package:task1/shared/cubit/cubit.dart';
import 'package:task1/shared/cubit/states.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppState>(
            builder: (context, state) {
              var cubit = AppCubit.get(context);
              return Scaffold(
                  body: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                          icon: const Icon(
                            Icons.arrow_circle_right_outlined,
                            weight: 10,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ConditionalBuilder(
                      builder: (BuildContext context) {
                        return Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, i) => NewsItem(
                                  context: context,
                                  DataList: cubit.initalData[i]),
                              separatorBuilder: (context, index) => Separtor(),
                              itemCount: cubit.initalData.length),
                        );
                      },
                      fallback: (BuildContext context) {
                        return const Expanded(
                          child:  Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Color.fromARGB(245, 158, 158, 158),
                              color:Color(0xFF3F92A4),
                            ),
                          ),
                        );
                      },
                      condition: true,
                    )
                  ],
                ),
              ));
            },
            listener: (context, state) {});
  }
}
