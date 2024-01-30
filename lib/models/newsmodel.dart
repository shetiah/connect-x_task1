// class NewsSource {
//   String id;
//   String name;
//   NewsSource(this.id, this.name);
// }
int idcount=0;
class News {

//  static int idcount=0;
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
      this.content){
        id=idcount++;
      }
  // source = NewsSource(sourceid, sourcename);
}
