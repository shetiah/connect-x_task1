import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task1/modules/home_page.dart';
import 'package:task1/modules/saved_page.dart';

import 'package:task1/modules/news_page.dart';
import 'package:task1/shared/cubit/states.dart';
import 'package:task1/shared/network/remote/dioHelper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitState());

  static AppCubit get(context) => BlocProvider.of(context);
  int loadingPrecentage = 0;

  String? lastQeuery;
  bool noResults = true;


  double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  WebViewController controllerWeb = WebViewController();
  void changeUrl({required String URL}) {
    // print(URL);
    controllerWeb.loadRequest(Uri.parse(URL)).then((value) {
      emit(ChangeUrlState());
    });
    controllerWeb.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (url) {
        loadingPrecentage = 0;
        emit(StartedLoadingUrlState());
      },
      onProgress: (progress) {
        loadingPrecentage = progress;
        emit(ProgressLoadingUrlState());
      },
      onPageFinished: (url) {
        loadingPrecentage = 100;
        emit(FinishedLoadingUrlState());
      },
    ));
  }

  List<Widget> screens = [
    const HomePage(),
    const MyNewsPage(),
    const SavedNews(),
  ];

  List<BottomNavigationBarItem> bottomNavItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.newspaper),
      label: "News",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.newspaper_sharp),
      label: "MyNews",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.save),
      label: "Saved",
    ),
  ];
  int bottomNavIndex = 0;

  void changeIndex(index) {
    bottomNavIndex = index;
    emit(ChangeBottomNavItems());
  }

  

  List<dynamic> initalData = [];
  
  List<dynamic> categoryData = [];
  List<dynamic> searchData = [];
// void getBuisnessFromApis() {
//     emit(LoadingBuisnessDataState());
//     businessData = [];
//     DioHelper.getData(
//       url: 'v2/top-headlines',
//       query: {
//         'country': 'US',
//         'category': 'business',
//         'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
//       },
//     ).then((value) {
//       //method data to extract data from response
//       businessData = value.data['articles'];
//       businessData.forEach((element) {
//         print(element["urlToImage"]);
//       });

//       emit(GetBuisnessDataState());
//     }).catchError((onError) {
//       print(onError.toString());
//       emit(BuisnessErrorState());
//     });
//   }
  void getInitalDataFromApis() {
    emit(LoadingInitalDataState());
    initalData = [];
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'US',
        'apiKey': '8dedceccd5ac40c9af3e745c70296f43',
      },
    ).then((value) {

      initalData = value.data['articles'];
      initalData.forEach((element) {
        print("-----------xx------");
        print(element["title"]);
        print("-----------xx------");
      });
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
        'country': 'US',
        'category':category,
        'apiKey': '8dedceccd5ac40c9af3e745c70296f43',
      },
    ).then((value) {
      categoryData = value.data['articles'];
      categoryData.forEach((element) {
        print("-----------xx------");
        print(element["title"]);
        print("-----------xx------");
      });
      emit(GetCategoricalDataState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetCatergoricalDataErrorState());
    });
  }

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
  //     emit(GetDataErrorState());
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

late Database database;
//  void createDatabase()
//  {
//   openDatabase(
//      'todo.db',
//      version: 1,
//      onCreate: (db, version) async {
//        print("database created");
//        // await db.execute(
//        //   'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,status TEXT) '
//        // );
//        db.execute('CREATE TABLE news (id INTEGER PRIMARY KEY,url TEXT,status TEXT) ').then((value) {
//          print("Table created");
//        }).catchError((onError){
//          print("error when creating Table ${onError.toString()}");
//        });
//      },
//      onOpen: (db) async{
//        print("database opened");
//        getdataDatabase(db);


//      },
//    ).then((value) {
//      database=value;
//      emit(CreateDBState());
//    });
//  }
// void updateData({
//   required String Status,
//   required int id
// }){
//   emit(UpdatingDatabseLoadingState());
//    database.rawUpdate(
//      'UPDATE tasks SET status = ? WHERE id = ?',
//      ['$Status',id]
//    ).then((value) {
//      getdataDatabase(database);
//      emit(UpdateDataStatus());
//    });

// }
//   insertToDB(
//      {
//        required String date,
//        required String time,
//        required String title,

//      }) async
//  {
//    await database.transaction(
//            (txn) {
//         return txn.rawInsert('INSERT INTO  tasks(title,date,time,status) VALUES("$title","$date","$time","new")').then((value)  {

//            print("$value is inserted");
//            emit(InsrtDBSte());
//            getdataDatabase(database);
//          }).catchError((error){
//            print("${error.toString()} my error");
//          });

//        }
//    );
//  }


//  getdataDatabase(db)
//  {
//    emit(GetDBLoadingSt());
//    archivedTasks=[];
//    newTasks=[];
//    doneTasks=[];
//  db.rawQuery('SELECT * FROM TASKS').then((value){
//     value.forEach((element) {
//       if(element['status']=='done')
//         {
//       doneTasks.add(element);
//         }
//       else if(element['status']=='archived')
//         {
//       archivedTasks.add(element);
//         }else{
//         newTasks.add(element);
//       }
//       emit(GetDBSte());
//     });
//   });

//   }

 Future<dynamic> alterTable(String TableName, String ColumneName,Database db) async {
  //NOTE: works but i created it by my own
   var count = await db.execute("ALTER TABLE $TableName ADD "
       "COLUMN $ColumneName TEXT;");
   print(await db.query(TableName));
   return count;
 }
}
