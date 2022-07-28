import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/board_screen/board_widgets.dart';
import 'package:todo_app/shared/cubit/app_cubit.dart';
import 'package:todo_app/shared/cubit/app_states.dart';



class BoardScreen extends StatefulWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> with SingleTickerProviderStateMixin {


  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state)
    {
      return Scaffold(
        appBar: boardAppBar(tabController: tabController , context: context),
        body: TabBarView(
            controller: tabController,
            children: [
             boardMainWidget(
               context: context,
               tabController: tabController,
               widget:  AppCubit.get(context).allData.isNotEmpty  ? ListView.separated(
                 scrollDirection: Axis.vertical,
                 itemBuilder: (context , index) =>  tasksList(AppCubit.get(context).allData[index] , context) ,
                 separatorBuilder: (context , index) => const SizedBox(
                   height: 10,
                 ),
                 itemCount: AppCubit.get(context).allData.length ) : const Image(image:  AssetImage('assets/emptyPage.png'))  ),

              ////////
              ///////
              //////

              boardMainWidget(
                context: context,
                tabController: tabController,
                widget: AppCubit.get(context).completedData.isNotEmpty  ? ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context , index) =>  tasksList(AppCubit.get(context).completedData[index] , context) ,
                    separatorBuilder: (context , index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: AppCubit.get(context).completedData.length ) : const Image(image:  AssetImage('assets/emptyPage.png'))  ),

              ////////
              ///////
              //////

              boardMainWidget(
                context: context,
                tabController: tabController,
                widget: AppCubit.get(context).unCompletedData.isNotEmpty  ? ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context , index) => tasksList(AppCubit.get(context).unCompletedData[index] , context) ,
                    separatorBuilder: (context , index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: AppCubit.get(context).unCompletedData.length ) : const Image(image:  AssetImage('assets/emptyPage.png'))  ),

              ////////
              ///////
              //////

              boardMainWidget(
                context: context,
                tabController: tabController,
                widget: AppCubit.get(context).favoriteData.isNotEmpty  ? ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context , index) =>  tasksList(AppCubit.get(context).favoriteData[index] , context) ,
                    separatorBuilder: (context , index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: AppCubit.get(context).favoriteData.length ) : const Image(image:  AssetImage('assets/emptyPage.png'))  ),


            ]
        ),


        //
      );

  }
    );
}
}