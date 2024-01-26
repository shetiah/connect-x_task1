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
import 'package:flutter/material.dart';
import 'package:task1/modules/web_view_screen.dart';
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
      child: Container(
        color:Color.fromARGB(255, 239, 238, 240),
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
                    : DecorationImage(
                        image: AssetImage('assets/myimage.png'),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SizedBox(width: 10),
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
                      color:
                         Color.fromARGB(255, 150, 123, 123),
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
    );
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
// _launchURL(String url) async {
//   if (await canLaunchUrl(Uri.parse(url))) {
//     await launchUrl(Uri.parse(url));
//   } else {
//     throw 'Could not launch $url';
//   }
// }
