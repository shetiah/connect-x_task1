class NewsSource {
  String id;
  String name;
  NewsSource(this.id, this.name);
}

class News {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
  String sourceid;
  String sourcename;
  NewsSource? source;

  News(
      this.sourceid,
      this.sourcename,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content) {
    source = NewsSource(sourceid, sourcename);
  }
}
