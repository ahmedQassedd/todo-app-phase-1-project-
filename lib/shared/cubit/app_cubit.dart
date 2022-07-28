import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/shared/cubit/app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitState());

  static AppCubit get(context) => BlocProvider.of(context);


  late Database database;
  String? dateClicked = DateFormat.yMd().format(DateTime.now());
  String? startTimeClicked ;
  String? endTimeClicked ;
  String? remindTimeClicked ;
  bool blueCircle = true ;
  bool redCircle = false ;
  List<Map> allData = [] ;
  List<Map> completedData = [] ;
  List<Map> unCompletedData = [] ;
  List<Map> favoriteData = [] ;

  void createDatabase() {
    debugPrint('database initialized');

    openDatabase('todoData.db',
        version: 1,
        onCreate: (database, version) {

          database
              .execute(
              'CREATE TABLE todoData (id INTEGER PRIMARY KEY, title TEXT, date TEXT, startTime TEXT, endTime TEXT , remind TEXT,  status TEXT, color TEXT, fav TEXT)')
              .then((value) {
            debugPrint('table created');
          }).catchError((onError) {
            debugPrint('error when : ${onError.toString()}');
          });
        },
        onOpen: (data) {
          database = data;

        }).then((value) {

          getDataBase();

      emit(AppDatabaseOpened());
    });
  }

  void insertIntoDatabase ({required title ,required date , required startTime , required endTime , required remind , required color }){
     database.transaction((txn) async {
        txn.rawInsert(
          'INSERT INTO todoData(title, date, startTime, endTime, remind, status, color, fav) VALUES("$title", "$date", "$startTime", "$endTime", "$remind", "unCompleted", "$color", "no")')
            .then((value) {

      emit(DatabaseInserted());
      getDataBase();
    });
     });
  }

  void getDataBase() {
    allData = [] ;
    completedData = [] ;
    unCompletedData = [] ;
    favoriteData = [] ;

    database.rawQuery('SELECT * FROM todoData').then((value) {


      value.forEach((element) {
        allData.add(element);
        if(element['status'] == 'completed'){
          completedData.add(element);
        }
        else if(element['status'] == 'unCompleted'){
          unCompletedData.add(element);
        }


      });

        allData.forEach((element) {

          if(element['fav'] == 'yes'){
            favoriteData.add(element);
          }
        });




      emit(DatabaseShowed());

    });
  }

  void updateItemFromDateBase({dataName, dataValue, id}) {
    database.rawUpdate('UPDATE todoData SET $dataName = ? WHERE id = ?',
        ['$dataValue', id]).then((value) {

      emit(ItemUpdated());
      getDataBase();
    });
  }

  void deleteItemFromDataBase(id) {
    database.rawDelete('DELETE FROM todoData WHERE id = ? ', [id]);

    emit(ItemDeleted());
    getDataBase();
  }





  List<String> itemList = [
    'All',
    'Completed',
    'UnCompleted',
    'Favorite',

  ];

  int currentItem = 0 ;

  void changeCurrentItem(index){
    currentItem = index ;
    emit(CurrentItemChanged());

  }


  void changeDate(newDate){

    dateClicked = newDate ;

    emit(NewDateChanged());

  }

  void changeStartTime(newStartTime){

    startTimeClicked = newStartTime ;

    emit(NewStartTimeChanged());

  }

  void changeEndTime(newEndTime){

    endTimeClicked = newEndTime ;

    emit(NewEndTimeChanged());

  }


  void changeRemindTime(newRemindTime){

    remindTimeClicked = newRemindTime ;

    emit(NewRemindTimeChanged());

  }




  void changeCircleColor (){
    redCircle = !redCircle ;
    blueCircle = !blueCircle ;

    emit(CircleColorChanged());
  }


  void showNotification(title , date ,startTime){
    
    var android = const AndroidNotificationDetails("channelId" , "channelName" , priority: Priority.high,);

    var ios = const IOSNotificationDetails();

    var platform = NotificationDetails(android: android  ,iOS: ios);

    flutterLocalNotificationsPlugin.schedule(0, 'Remind you to $title', 'On: $date   At: $startTime', DateTime.now().add(const Duration(seconds: 60) , ), platform);


  }






}