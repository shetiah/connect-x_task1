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
     Icon i=const Icon(Icons.signal_cellular_null) ;
    for (var e in News.allNewsBkMk) {
      if (e.containsKey(newsItem.url)) {
         i= e[newsItem.url]!.bookMarked
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
          await updateData(bookmarked: "no", url: newsitem.url);
          var tempe ;
          for (var e2 in bookMarkedData) {
            if (e2['url'] == newsitem.url) {
              tempe=e2;
            }
          }
          bookMarkedData.remove(tempe);
        } else {
          newsitem.bookMarked = true;
          element[newsitem.url]?.bookMarked = true;
          bool alreadyExist = false;
          for (var element in newsItemDatadb) {
            if (element['url'] == newsitem.url) {
              bookMarkedData.add(element);
              alreadyExist = true;
            }
          }
          if (!alreadyExist) {
            emit(BookMarkErrorState());
          }
          await updateData(bookmarked: "yes", url: newsitem.url);
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
  List<dynamic> newsItemDatadb = [];

  void getInitalDataFromApis() {
    emit(LoadingInitalDataState());
    initalData = [];
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'apiKey': '8dedceccd5ac40c9af3e745c70296f43',
      },
    ).then((value) {
      initalData = value.data['articles'];
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
      for (var element in categoryData) {
        print("-----------xx------");
        print(element["urlToImage"]);
        print("-----------xx------");
      }
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
                'CREATE TABLE news (author TEXT,title TEXT, description TEXT,url Text PRIMARY KEY,urlToImage Text,publishedAt Text,content Text,bookmarked Text) ')
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

  Future<void> updateData(
      {required String bookmarked, required String url}) async {
    emit(UpdatingDatabseLoadingState());
    database.rawUpdate('UPDATE news SET bookmarked = ? WHERE url = ?',
        [bookmarked, url]).then((value) {
      getdataDatabase(database);
      emit(UpdateDataStatus());
    });
  }

  Future<void> insertToDB({
    required News newsitem,
  }) async {
    for (var element in newsItemDatadb) {
      if (newsitem.url == element['url']) {
        return;
      }
    }

    await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO news(author,title,description,url,urlToImage,publishedAt,content,bookmarked) VALUES("${newsitem.author}","${newsitem.title}","${newsitem.description}","${newsitem.url}","${newsitem.urlToImage}","${newsitem.publishedAt}","${newsitem.content}","no")')
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
    newsItemDatadb = [];
    News.allNewsBkMk=[];
    db.rawQuery('SELECT * FROM news').then((value) {
      value.forEach((element) {
        if (element['bookmarked'] == 'yes') {
          bookMarkedData.add(element);
        }
        newsItemDatadb.add(element);
        News temp = News(
            element['author'],
            element['title'],
            element['description'],
            element['url'],
            element['urlToImage'],
            element['publishedAt'],
            element['content']);
        temp.bookMarked = element['bookmarked'] == 'yes' ? true : false;
        News.allNewsBkMk.add({element['url']: temp});
      });
      emit(GetDatabaseState());
    });
  }

  // void deleteItem({required id}) {
  //   emit(DeletingDatabseLoadingState());
  //   database.rawDelete('DELETE FROM news WHERE id = ?', [id]).then((value) {
  //     getdataDatabase(database);
  //     emit(DeleteDataStatus());
  //   });
  // }
}
