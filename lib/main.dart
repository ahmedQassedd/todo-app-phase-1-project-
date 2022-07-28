import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app/modules/board_screen/board_screen.dart';
import 'package:todo_app/shared/components.dart';
import 'package:todo_app/shared/cubit/app_cubit.dart';
import 'package:todo_app/shared/cubit/app_states.dart';
import 'package:todo_app/shared/cubit/bloc_observer/bloc_observer.dart';


 late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin ;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  flutterLocalNotificationsPlugin =  FlutterLocalNotificationsPlugin();
  var android = const AndroidInitializationSettings("mipmap/ic_launcher");
  var ios = const IOSInitializationSettings();
  var initSetting = InitializationSettings(android: android , iOS: ios);
  await flutterLocalNotificationsPlugin.initialize(initSetting,
      onSelectNotification: (String? payload) async {
        debugPrint('hello');
      });



  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) {
            return MaterialApp(
              theme: lightingTheme(),
              debugShowCheckedModeBanner: false,
              home: const BoardScreen() ,
            );
          }),
    );
  }
}




