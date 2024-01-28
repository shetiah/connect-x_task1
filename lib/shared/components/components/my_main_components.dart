// import 'package:flutter/material.dart';

// Widget defaultFormField({
//   required TextEditingController controller,
//   required TextInputType type,
//   Function? onSubmit,
//   Function? onChange,
//   Function? onTap,
//   bool isPassword = false,
//   required Function validate,
//   required String label,
//   required IconData prefix,
//   IconData? suffix,
//   Function? suffixPressed,
//   bool isClickable = true,
//   required dynamic context,
// }) =>
//     TextFormField(
//       controller: controller,
//       keyboardType: type,
//       obscureText: isPassword,
//       enabled: isClickable,
//       onFieldSubmitted: (s) {
//         onSubmit!(s);
//       },
//       onChanged: (s) {
//         onChange!(s);
//       },
//       onTap: () {
//         onTap!();
//       },
//       validator: (s) {
//         return validate(s);
//       },
//       decoration: InputDecoration(
//         prefixIconColor: GetMyDefColor1(context),
//         suffixIconColor: GetMyDefColor1(context),
//         labelText: label,
//         labelStyle: TextStyle(
//           color: GetMyDefColor1(context),
//         ),
//         prefixIcon: Icon(
//           prefix,
//         ),
//         suffixIcon: suffix != null
//             ? IconButton(
//                 onPressed: () {
//                   suffixPressed!();
//                 },
//                 icon: Icon(
//                   suffix,
//                   size: 20,
//                 ),
//               )
//             : null,
//         border: OutlineInputBorder(),
//       ),
//     );
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:task1/modules/categoriees_screen.dart';
import 'package:task1/modules/web_view.dart';
import 'package:task1/shared/components/constants/const.dart';
import 'package:task1/shared/cubit/cubit.dart';

Widget Separtor() => Container(
      color: Colors.grey[300],
      height: 1,
      width: double.infinity,
    );
Widget NewsItem({
  required BuildContext context,
  required Map<String, dynamic> DataList,
}) =>
    InkWell(
      onTap: () {
        AppCubit.get(context).changeUrl(URL: '${DataList['url']}');
        // _launchURL('${DataList['url']}');
        navigateTo(context, WebScreen());
      },
      child: Dismissible(
        key: Key(""),
        onDismissed: (direction) {
          
        },
        child: Container(
          color: Color.fromARGB(255, 239, 238, 240),
          child: Row(
            children: [
              Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  image: DataList["urlToImage"] != null
                      ? DecorationImage(
                          image: NetworkImage(DataList["urlToImage"]),
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
                      "${DataList["title"]}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GetMyDefTextStyle1(context),
                    ),
                    Text(
                      "${DataList["description"]}",
                      // style:Theme.of(context).textTheme.bodyMedium ,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 150, 123, 123),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget myImage({required String urlToImage, required String ctg,required BuildContext context}) =>  InkWell(
      onTap: () {
         navigateTo(context, CategoriesPage(ctg));
      },
  child: Container(
        width: 160.0,
        height: 160.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        
          image: DecorationImage(
            image: AssetImage(urlToImage),
            fit: BoxFit.cover,
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
          const  SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style:const TextStyle(
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
          const  SizedBox(
              width: 20.0,
            ),
            IconButton(
              onPressed: () {
                // AppCubit.get(context).updateData(
                //   status: 'done',
                //   id: model['id'],
                // );
              },
              icon: Icon(
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
              icon: Icon(
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
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) {
          return buildTaskItem(tasks[index], context);
        },
        separatorBuilder: (context, index) => myDivider(),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
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
