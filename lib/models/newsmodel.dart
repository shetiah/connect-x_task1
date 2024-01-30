// class NewsSource {
//   String id;
//   String name;
//   NewsSource(this.id, this.name);
// }

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task1/shared/cubit/cubit.dart';

class News {
 static int nextid=1;
  late int id;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
  // String sourceid;
  // String sourcename;
  // NewsSource? source;
  bool bookMarked = false;

  News(
      // this.sourceid,
      // this.sourcename,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content)  {
        id=nextid-1;
        nextid++;
      }
     Future<void> insrtelementdb(context)
     async {
      await AppCubit.get(context).insertToDB(newsitem: this);
     }
  // source = NewsSource(sourceid, sourcename);
}
