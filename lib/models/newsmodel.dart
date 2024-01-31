

import 'package:task1/shared/cubit/cubit.dart';

class News {
//  static int nextid=1;
 static List< Map<String,News>> allNewsBkMk=[];
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
  bool bookMarked = false;

  News(
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content)  {
        // Map<int,News> temp={id:this};
        // allNews.add(temp);
      }
    //  Future<void> insrtelementdb(context)
    //  async {
    //   await AppCubit.get(context).insertToDB(newsitem: this);
    //  }
  // source = NewsSource(sourceid, sourcename);
}
