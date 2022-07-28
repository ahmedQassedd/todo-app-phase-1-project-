import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/task_screen/task_widgets.dart';
import 'package:todo_app/shared/cubit/app_cubit.dart';
import 'package:todo_app/shared/cubit/app_states.dart';


class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
      return Scaffold(
        appBar: taskAppBar(context),
        body: mainTaskWidget(context),
      );
    });
  }
}
