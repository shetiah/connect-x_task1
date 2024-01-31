import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task1/models/newsmodel.dart';
import 'package:task1/modules/home_screen.dart';
import 'package:task1/modules/bookmarked_screen.dart';

import 'package:task1/modules/categories_choice_screen.dart';
import 'package:task1/shared/cubit/states.dart';
import 'package:task1/shared/network/remote/dioHelper.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitState());

  static AppCubit get(context) => BlocProvider.of(context);
  int loadingPrecentage = 0;

  String? lastQeuery;
  bool noResults = true;
  // Icon realbkmarkIcon = unBookMarkedicon;
  Icon getSuitableBookMark({required News newsItem}) {
    Icon i = const Icon(Icons.signal_cellular_null);
    for (var e in News.allNewsBkMk) {
      if (e.containsKey(newsItem.url)) {
        i = e[newsItem.url]!.bookMarked
            ? const Icon(Icons.bookmark)
            : const Icon(Icons.bookmark_outline);
      }
    }

    // print(newsItem.bookMarked);
    emit(GetBookMark());
    return i;
  }

  Future<void> bookMark(News newsitem) async {
    for (var element in News.allNewsBkMk) {
      if (element.containsKey(newsitem.url)) {
        if (element[newsitem.url]!.bookMarked) {
          newsitem.bookMarked = false;
          element[newsitem.url]?.bookMarked = false;
          await deleteFromdbunbk(url: newsitem.url);
        } else {
          newsitem.bookMarked = true;
          element[newsitem.url]?.bookMarked = true;
          await insertToDB(newsitem: newsitem);
        }
      }
    }
    emit(BookMarkedState());
  }

  Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);

  double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  List<Widget> screens = [
    const HomePage(),
    const MyNewsPage(),
    const BookMarkedScreen(),
  ];

  int bottomNavIndex = 0;

  void changeIndex(index) {
    bottomNavIndex = index;
    emit(ChangeBottomNavItems());
  }

  List<dynamic> initalData = [];

  List<dynamic> categoryData = [];

  List<dynamic> bookMarkedData = [];

  void getInitalDataFromApis() {
    emit(LoadingInitalDataState());
    initalData = [];
    // News.allNewsBkMk = [];
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'apiKey': '8dedceccd5ac40c9af3e745c70296f43',
      },
    ).then((value) {
      initalData = value.data['articles'];
      initalData.forEach((i) {
        News temp = News(
            i['author'] ?? "",
            i['title'] ?? "",
            i['description'] ?? "",
            i['url'] ?? "",
            i['urlToImage'] ?? "",
            i['publishedAt'] ?? "",
            i['content'] ?? "");
        bool x = false;
        
        if (x == false) {
          News.allNewsBkMk.add({i['url']: temp});
        }
      });
      // for (var i in initalData) {}
      emit(GetInitDataState());
    }).catchError((onError) {
      print(onError.toString());
      emit(InitErrorState());
    });
  }

  void getCategoricalDataFromApis({required String category}) {
    emit(LoadingCategoricalDataState());
    categoryData = [];

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': category,
        'apiKey': '8dedceccd5ac40c9af3e745c70296f43',
      },
    ).then((value) {
      categoryData = value.data['articles'];
      categoryData.forEach((element) {
        News temp = News(
          element["author"] ?? "",
          element["title"] ?? "",
          element["description"] ?? "",
          element["url"] ?? "",
          element["urlToImage"] ?? "",
          element["publishedAt"] ?? "",
          element["content"] ?? "",
        );
        bool x = false;
        for (var n in News.allNewsBkMk) {
          if (n.containsKey(element['url'])) {
            x = true;
          }
        }
        if (x == false) {
          News.allNewsBkMk.add({element['url']: temp});
        }
      });

      emit(GetCategoricalDataState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetCatergoricalDataErrorState());
    });
  }

  late Database database;
  void createDatabase() {
    openDatabase(
      'news.db',
      version: 1,
      onCreate: (db, version) async {
        print("database created");
        db
            .execute(
                'CREATE TABLE news (url Text PRIMARY KEY,author Text,title Text,description Text,urlToImage Text,publishedAt text,content text)')
            .then((value) {
          print("Table created");
        }).catchError((onError) {
          print("error when creating Table ${onError.toString()}");
        });
      },
      onOpen: (db) async {
        print("database opened");

        getdataDatabase(db);
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseState());
    });
  }

  // Future<void> updateData(
  //     {required String bookmarked, required String url}) async {
  //   emit(UpdatingDatabseLoadingState());
  //   database.rawUpdate('UPDATE news SET bookmarked = ? WHERE url = ?',
  //       [bookmarked, url]).then((value) async {
  //    await getdataDatabase(database);
  //     emit(UpdateDataStatus());
  //   });
  // }

  Future<void> insertToDB({
    required News newsitem,
  }) async {
    
    for (var element in bookMarkedData) {
      if (newsitem.url == element['url']) {
        return;
      }
    }

    await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO news(url,author,title ,description,urlToImage,publishedAt,content) VALUES("${newsitem.url}","${newsitem.author}","${newsitem.title}","${newsitem.description}","${newsitem.urlToImage}","${newsitem.publishedAt}","${newsitem.content}")')
          .then((value) async {
        emit(InsertDatabaseState());
        await getdataDatabase(database);
      }).catchError((error) {
        print("${error.toString()} my error");
      });
    });
  }

  getdataDatabase(db) {
    emit(GetDatabaseLoadingState());
    bookMarkedData = [];
    db.rawQuery('SELECT * FROM news').then((value) {
      value.forEach((element) {
          bookMarkedData.add(element);
        for (var i in News.allNewsBkMk) {
          if (i.containsKey(element['url'])) {
            i[element['url']]?.bookMarked =true;
          }
        }
      });
      emit(GetDatabaseState());
    });
  }

  Future<void> deleteFromdbunbk({required url}) async {
    emit(DeletingDatabseLoadingState());
    await database
        .rawDelete('DELETE FROM news WHERE url = ?', [url]).then((value) async {
      await getdataDatabase(database);
      emit(DeleteDataStatus());
    });
  }
}
