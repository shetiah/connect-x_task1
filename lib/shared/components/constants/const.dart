// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/shared/cubit/cubit.dart';

// Color GetMyDefColor1(dynamic context) {
//   //color for search screen
//   return NewsAppCubit.get(context).isDark ? Colors.white : Colors.black;
// }
import 'package:flutter/material.dart';

TextStyle GetMyDefTextStyle1(dynamic context) {
  //color for listNews screen
  return const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color:  Colors.black);
}
 Icon unBookMarkedicon=const Icon(Icons.bookmark_border_rounded,color: Colors.black,);
  Icon bookmarkedicon=const Icon(Icons.bookmark,color: Colors.black,);
  