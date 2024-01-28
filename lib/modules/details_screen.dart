import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/models/newsmodel.dart';
import 'package:task1/shared/cubit/cubit.dart';
import 'package:task1/shared/cubit/states.dart';

class Details_Screen extends StatelessWidget {
  News myNewsItem;
  Details_Screen(this.myNewsItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            body: SafeArea(
                child: Column(
              children: [
                Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(myNewsItem.urlToImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            )),
          );
        },
        listener: (context, stae) {});
  }
}
