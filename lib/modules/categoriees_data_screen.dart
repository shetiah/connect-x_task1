import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/shared/components/components/my_main_components.dart';
import 'package:task1/shared/cubit/cubit.dart';
import 'package:task1/shared/cubit/states.dart';

class CategoriesPage extends StatelessWidget {
  final String categoryType;
  const CategoriesPage(this.categoryType, {super.key});

  @override
  Widget build(BuildContext context) {
   AppCubit.get(context).getCategoricalDataFromApis(category: categoryType);
          
    return BlocConsumer<AppCubit, AppState>(
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_outlined,size:24),
                  onPressed: () {Navigator.pop(context);},
                ),
                title: const Text("NewsApp"),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.mic),
                    onPressed: () {},
                  ),
                ],
              ),
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
                              itemBuilder: (context, i) => newsItem(
                                  context: context,
                                  dataList: cubit.categoryData[i]),
                              separatorBuilder: (context, index) => separtor(),
                              itemCount: cubit.categoryData.length),
                        );
                      },
                      fallback: (BuildContext context) {
                        return const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor:
                                  Color.fromARGB(245, 158, 158, 158),
                              color: Color(0xFF3F92A4),
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
