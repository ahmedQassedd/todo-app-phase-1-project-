import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/calender_screen/calender_widgets.dart';
import 'package:todo_app/shared/cubit/app_cubit.dart';
import 'package:todo_app/shared/cubit/app_states.dart';


class CalenderScreen extends StatelessWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
      return Scaffold(
        appBar: calenderAppBar(context),
        body: mainCalenderWidget(context),
      );
    });
  }
}
