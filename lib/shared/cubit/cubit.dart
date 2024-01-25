import 'dart:core';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/shared/cubit/states.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitState());

  static AppCubit get(context) => BlocProvider.of(context);
  // int loadingPrecentage = 0;
  // bool isDark = false;
  // Timer? timer;
  // int seconds = 0;
  // bool isRunning = false;
  // void startTimer() {
  //   isRunning = true;
  //   timer = Timer.periodic(Duration(seconds: 1), (Timer) {
  //     seconds++;
  //     emit(SecondTickState());
  //   });
  //   emit(TimerStartedState());
  // }

  // void stopTimer() {
  //   timer?.cancel();
  //   isRunning = false;
  //   emit(TimerCanceledState());
  // }

  // WebViewController controllerWeb = WebViewController();
  // void changeUrl({required String URL}) {
  //   controllerWeb.loadRequest(Uri.parse(URL)).then((value) {
  //     emit(ChangeUrlState());
  //   });
  //   controllerWeb.setNavigationDelegate(NavigationDelegate(
  //     onPageStarted: (url) {
  //       loadingPrecentage = 0;
  //       emit(StartedLoadingUrlState());
  //     },
  //     onProgress: (progress) {
  //       loadingPrecentage = progress;
  //       emit(ProgressLoadingUrlState());
  //     },
  //     onPageFinished: (url) {
  //       loadingPrecentage = 100;
  //       emit(FinishedLoadingUrlState());
  //     },
  //   ));
  // }

  // void changeThemeMode({bool? isdark}) {
  //   if (isdark == null) {
  //     isDark = !isDark;
  //     CacheHelper.sharedPreferences?.setBool('isDark', isDark).then((value) {
  //       emit(ChangeThemeModeState());
  //     });
  //   } else {
  //     isDark = isdark;
  //     emit(ChangeThemeModeState());
  //   }
  // }

  // List<Widget> Screens = [
  //   BuisnessScreen(),
  //   SportsScreen(),
  //   ScienceScreen(),
  // ];

  // List<BottomNavigationBarItem> BottomNavItems = [
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.cases_outlined),
  //     label: "Buisness",
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.science),
  //     label: "Science",
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.sports_basketball_outlined),
  //     label: "Sports",
  //   ),
  // ];
  // int BottomNavIndex = 0;

  // void changeIndex(index) {
  //   this.BottomNavIndex = index;
  //   emit(ChangeBottomNavItems());
  // }

  // List<dynamic> sportsData = [];
  // List<dynamic> businessData = [];
  // List<dynamic> scienceData = [];
  // List<dynamic> searchData = [];

  // void getBuisnessFromApis() {
  //   emit(LoadingBuisnessDataState());
  //   businessData = [];
  //   DioHelper.getData(
  //     url: 'v2/top-headlines',
  //     query: {
  //       'country': 'US',
  //       'category': 'business',
  //       'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
  //     },
  //   ).then((value) {
  //     //method data to extract data from response
  //     businessData = value.data['articles'];
  //     businessData.forEach((element) {
  //       print(element["urlToImage"]);
  //     });

  //     emit(GetBuisnessDataState());
  //   }).catchError((onError) {
  //     print(onError.toString());
  //     emit(BuisnessErrorState());
  //   });
  // }

  // void getSportsFromApis() {
  //   sportsData = [];
  //   DioHelper.getData(url: 'v2/top-headlines', query: {
  //     'country': 'US',
  //     'category': 'sports',
  //     'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
  //   }).then((value) {
  //     //method data to extract data from response
  //     sportsData = value.data['articles'];
  //     emit(GetScienceDataState());
  //   }).catchError((onError) {
  //     print(onError.toString());
  //     emit(SportsErrorState());
  //   });
  // }

  // void getScienceFromApis() {
  //   scienceData = [];
  //   DioHelper.getData(url: 'v2/top-headlines', query: {
  //     'country': 'US',
  //     'category': 'science',
  //     'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
  //   }).then((value) {
  //     //method data to extract data from response
  //     scienceData = value.data['articles'];
  //     emit(GetScienceDataState());
  //   }).catchError((onError) {
  //     print(onError.toString());
  //     emit(ScienceErrorState());
  //   });
  // }

  // String? LastQuery;
  // bool noResults = true;
  // void searchOnData({required String tobeSearched}) {
  //   if (tobeSearched == LastQuery) return;
  //   emit(LoadingSearchState());
  //   LastQuery = tobeSearched;
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
}
