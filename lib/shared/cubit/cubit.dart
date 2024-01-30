import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task1/models/newsmodel.dart';
import 'package:task1/modules/home_screen.dart';
import 'package:task1/modules/bookmarked_screen.dart';

import 'package:task1/modules/categories_choice_screen.dart';
import 'package:task1/shared/components/constants/const.dart';
import 'package:task1/shared/cubit/states.dart';
import 'package:task1/shared/network/remote/dioHelper.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitState());

  static AppCubit get(context) => BlocProvider.of(context);
  int loadingPrecentage = 0;

  String? lastQeuery;
  bool noResults = true;
  Icon bookMarkdIcon = bookMarkedstate;

  void bookMark(News newsitem) {
    if (newsitem.bookMarked) {
      updateData(bookmarked: "no", id: newsitem.id);
      bookMarkdIcon = unBookMarkedstaet;
    } else {
      bool alreadyExist = false;
      for (var element in bookMarkedData) {
        if (element['id'] == newsitem.id) {
          alreadyExist = true;
        }
      }
      if (alreadyExist) {
        updateData(bookmarked: "yes", id: newsitem.id);
      } else {
        insertToDB(
            author: newsitem.author,
            title: newsitem.title,
            description: newsitem.description,
            url: newsitem.url,
            urlToImage: newsitem.urlToImage,
            publishedAt: newsitem.publishedAt,
            content: newsitem.content);
        updateData(bookmarked: "yes", id: newsitem.id);
      }
      bookMarkdIcon = bookMarkedstate;
    }
    newsitem.bookMarked = !newsitem.bookMarked;
    emit(BookMarkedState());
  }

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
  List<dynamic> searchData = [];

  List<dynamic> bookMarkedData = [];

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

        // late int id;
        // String author;
        // String title;
        // String description;
        // String url;
        // String urlToImage;
        // String publishedAt;
        // String content;
        // // String sourceid;
        // // String sourcename;
        // // NewsSource? source;
        // bool bookMarked = false;
        db
            .execute(
                'CREATE TABLE news (id INTEGER PRIMARY KEY,author TEXT,title TEXT, description TEXT,url Text,urlToImage Text,publishedAt Text,content Text,bookmarked Text) ')
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

  void updateData({required String bookmarked, required int id}) {
    emit(UpdatingDatabseLoadingState());
    database.rawUpdate('UPDATE news SET bookmarked = ? WHERE id = ?',
        [bookmarked, id]).then((value) {
      getdataDatabase(database);
      emit(UpdateDataStatus());
    });
  }

  insertToDB({
    required String author,
    required String title,
    required String description,
    required String url,
    required String urlToImage,
    required String publishedAt,
    required String content,
  }) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO  news(author,title,description,url,urlToImage,publishedAt,content,bookmarked) VALUES("$author","$title","$description","$url","$urlToImage","$publishedAt","$content","no")')
          .then((value) {
        print("$value is inserted");
        emit(InsertDatabaseState());
        getdataDatabase(database);
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
        if (element['bookmarked'] == 'yes') {
          bookMarkedData.add(element);
        }
      });

      emit(GetDatabaseState());
    });
  }

//  Future<dynamic> alterTable(String TableName, String ColumneName,Database db) async {
//   //NOTE: works but i created it by my own
//    var count = await db.execute("ALTER TABLE $TableName ADD "
//        "COLUMN $ColumneName TEXT;");
//    print(await db.query(TableName));
//    return count;
//  }

  // void searchOnData({required String tobeSearched}) {
  //   if (tobeSearched == lastQeuery) return;
  //   emit(LoadingSearchState());
  //   lastQeuery = tobeSearched;
  //   // startTimer();
  //   searchData = [];
  //   bool blank = tobeSearched?.trim()?.isEmpty ?? true;
  //   if (blank) {
  //     noResults = true;
  //     emit(SearchDataState());
  //     return;
  //   }

  //   DioHelper.getData(
  //     url: 'v2/everything',
  //     query: {
  //       'q': '$tobeSearched',
  //       'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
  //     },
  //   ).then((value) {
  //     //method data to extract data from response
  //     searchData = value.data['articles'];

  //     if (searchData == null || searchData.isEmpty) {
  //       print(searchData);
  //       noResults = true;
  //     } else {
  //       noResults = false;
  //     }
  //     print(noResults);
  //     emit(SearchDataState());
  //   }).catchError((e) {
  //     // The request was made and the server responded with a status code
  //     // that falls out of the range of 2xx and is also not 304.
  //     if (e.response != null) {
  //       print(e.response.data);
  //       print(e.response.headers);
  //       print(e.response.requestOptions);
  //     } else {
  //       // Something happened in setting up or sending the request that triggered an Error
  //       print(e.requestOptions);
  //       print(e.message);
  //     }
  //     emit(GetDatusrrorState());
  //   });
  // }

//   void deleteTask({
//    required id
// })
// {
//  emit(DeletingDatabseLoadingState());
//   database.rawDelete('DELETE FROM tasks WHERE id = ?', [id])
//       .then((value)
//   {
//     getdataDatabase(database);
//     emit(DeleteDataStatus());
//   });
// }
}
