
import 'package:flutter/material.dart';
import 'package:todo_app/modules/calender_screen/calender_screen.dart';
import 'package:todo_app/modules/task_screen/task_screen.dart';
import 'package:todo_app/shared/components.dart';
import 'package:todo_app/shared/cubit/app_cubit.dart';



AppBar boardAppBar({tabController, context }) =>
  AppBar(
    title: const Text('Board'),
    actions: [
      IconButton(
          onPressed: () {
            navigateTo(context: context, widget: const CalenderScreen());
          }, icon: const Icon(Icons.calendar_today))
    ],
    bottom: TabBar(
      indicatorColor: Colors.black,
      labelPadding: EdgeInsets.zero,
      labelColor: Colors.black,
      controller: tabController,
      tabs: const [
        Tab(text:'All' , ),
        Tab(text: 'Completed',),
        Tab(text: 'Uncompleted',),
        Tab(text: 'Favorite',),
      ],
    ),
    elevation: 0.5,
  );


Widget boardMainWidget({context , tabController , widget}) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 0 , horizontal: 16),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [

      Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey[300],
      ),
      const SizedBox(
        height: 20,
      ),

      Expanded(
        child: widget ,
      ),
      customButton(text: 'Add a Task', color: Colors.green, onPressed: (){
        navigateTo(context: context, widget: const TaskScreen());


      }),

      const SizedBox(
        height: 20,
      ),
    ],
  ),
);





Widget tasksList(Map model , context) =>

  Column(
    children:  [

       Padding(
           padding: const  EdgeInsets.all(10),

         child: Row(children: [
           Column(children: [

             if(model['status'] == 'completed'  )
               CircleAvatar(
                 radius: 15,
                 backgroundColor:  model['color'] == 'blue' ? Colors.blue : Colors.red,
                 child: const Icon(Icons.check , color: Colors.white , size: 15,),
               ),

             if(model['status'] == 'unCompleted'  )
               GestureDetector(
                 onTap: (){
                   AppCubit.get(context).updateItemFromDateBase(dataName: 'status', dataValue: 'completed', id: model['id']);
                 },
                 child: CircleAvatar(
                   radius: 15,
                   backgroundColor:  model['color'] == 'blue' ? Colors.blue : Colors.red,
                   child: const CircleAvatar(
                     radius: 13,
                     backgroundColor:  Colors.white ,
                   ),
                 ),
               ),

           ],),
           const SizedBox(
             width: 10,
           ),
           Expanded(
             child: Text(
               model['title'],
               maxLines: 1,
               style: Theme.of(context)
                   .textTheme
                   .subtitle2!.copyWith(overflow: TextOverflow.ellipsis , )
                  ,
             ),
           ),
           PopupMenuButton(
               icon: const Icon(Icons.keyboard_arrow_down_sharp),
               elevation: 10.0,
               onSelected: (value) {
                 if (value == 1) {
                   AppCubit.get(context).updateItemFromDateBase(dataName: 'status', dataValue: 'completed', id: model['id']);
                 }

                 if (value == 2) {
                   AppCubit.get(context).updateItemFromDateBase(dataName: 'fav' , dataValue: 'yes' , id: model['id']);
                 }

                 if (value == 3) {
                   AppCubit.get(context).deleteItemFromDataBase(model['id']);
                 }
               },
               itemBuilder: (context) => const [
                 PopupMenuItem(
                   value: 1,
                   child: Text("Completed"),
                 ),
                 PopupMenuItem(

                   value: 2,
                   child: Text("Favorite"),
                 ),
                 PopupMenuItem(
                   value: 3,
                   child: Text("Delete"),
                 ),
               ])

         ],)
       ),


    ],
  );
