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



// // POS;
// // UPDATE
// // DELETE

// // GET

// // base url : https://newsapi.org/
// // method (url) : v2/top-headlines?
// // queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca