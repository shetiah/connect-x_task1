import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task1/models/newsmodel.dart';
import 'package:task1/shared/cubit/cubit.dart';
import 'package:task1/shared/cubit/states.dart';

class Details_Screen extends StatelessWidget {
  News myNewsItem;
  Details_Screen(this.myNewsItem, {super.key});

  @override
  Widget build(BuildContext context) {
    // print(DateFormat.yMMMd().format(DateTime.now()));
    return BlocConsumer<AppCubit, AppState>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            body: SafeArea(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.all(cubit.getScreenWidth(context) * .01),
                    child: Stack(
                      children: [
                        Container(
                          width: cubit.getScreenWidth(context),
                          height: cubit.getScreenHeight(context) * .4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              20.0,
                            ),
                            image: myNewsItem.urlToImage.isNotEmpty
                                ? DecorationImage(
                                    image: NetworkImage(myNewsItem.urlToImage),
                                    fit: BoxFit.cover,
                                  )
                                : const DecorationImage(
                                    image: AssetImage('assets/icons/news.png'),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Positioned.fill(
                          top: cubit.getScreenHeight(context) * .35,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20.0)),
                            ),
                            child: Column(
                              children: [
                                Text(myNewsItem.title,style: Theme.of(context).textTheme.titleLarge,),
                              Text(myNewsItem.description,style:Theme.of(context).textTheme.bodySmall),
                              Align(child: Text((DateFormat.yMMMd().parse(myNewsItem.publishedAt)).toString()),alignment: Alignment.bottomRight,),
                              ],
                            ),

                            width: cubit.getScreenWidth(context),
                          ),
                        ),
                      ],
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
