import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:task1/models/newsmodel.dart';
import 'package:task1/modules/categoriees_data_screen.dart';
import 'package:task1/modules/details_screen.dart';
import 'package:task1/shared/cubit/cubit.dart';

Widget separtor() => const SizedBox(
      height: 10,
      width: double.infinity,
    );
Widget newsItem({
  required BuildContext context,
  required Map<String, dynamic> dataList,
}) =>
    InkWell(
      onTap: () {
        // AppCubit.get(context).changeUrl(URL: '${dataList['url']}');
        // _launchURL('${dataList['url']}');
        News newsItem = News(
          dataList["author"] ?? "",
          dataList["title"] ?? "",
          dataList["description"] ?? "",
          dataList["url"] ?? "",
          dataList["urlToImage"] ?? "",
          dataList["publishedAt"] ?? "",
          dataList["content"] ?? "",
        );
        // newsItem.insrtelementdb(context);
        navigateTo(context, Details_Screen(newsItem));
      },
      child: Row(
        children: [
          Container(
            width: AppCubit.get(context).getScreenWidth(context) * .3,
            height: AppCubit.get(context).getScreenWidth(context) * .3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
              image: dataList["urlToImage"] != null
                  ? DecorationImage(
                      image: NetworkImage(dataList["urlToImage"]),
                      fit: BoxFit.cover,
                    )
                  : const DecorationImage(
                      image: AssetImage('assets/icons/news.png'),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Text(
                  "${dataList["title"]}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  maxLines: 2,
                  "${dataList["description"]}",
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          ),
        ],
      ),
    );
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget myImage(
        {required String textname,
        required Color color,
        required Color txtColor,
        required String urlToImage,
        required String ctg,
        required BuildContext context}) =>
    InkWell(
      onTap: () {
        navigateTo(context, CategoriesPage(ctg));
      },
      child: Container(
        height: AppCubit.get(context).getScreenHeight(context) * .21,
        width: AppCubit.get(context).getScreenHeight(context) * .2,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: AppCubit.get(context).getScreenHeight(context) * .007,
              ),
              Center(
                child: Container(
                  width: AppCubit.get(context).getScreenHeight(context) * .15,
                  height: AppCubit.get(context).getScreenHeight(context) * .15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                    image: DecorationImage(
                      image: AssetImage(urlToImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: AppCubit.get(context).getScreenHeight(context) * .006,
              ),
              Text(textname,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: txtColor,
                        fontWeight: FontWeight.bold,
                      ))
            ],
          ),
        ),
      ),
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                '${model['time']}',
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            IconButton(
              onPressed: () {
                // AppCubit.get(context).updateData(
                //   status: 'done',
                //   id: model['id'],
                // );
              },
              icon: const Icon(
                Icons.check_box,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                // AppCubit.get(context).updateData(
                //   status: 'archive',
                //   id: model['id'],
                // );
              },
              icon: const Icon(
                Icons.archive,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        // AppCubit.get(context).deleteData(
        //   id: model['id'],
        // );
      },
    );

Widget tasksBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) {
          return buildTaskItem(tasks[index], context);
        },
        separatorBuilder: (context, index) => myDivider(),
        itemCount: tasks.length,
      ),
      fallback: (context) => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

String getDateFromApis(String dateAndTime) {
  String date = dateAndTime.split("T")[0];
  return date;
}
// String getTimeFromApi(String dateAndTime)
// {
//    String time = dateAndTime.split("T")[1];
//    return time;
// }
