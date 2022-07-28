import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/components.dart';
import 'package:todo_app/shared/cubit/app_cubit.dart';





var titleController = TextEditingController();
var formKey = GlobalKey<FormState>();


AppBar taskAppBar(context) => AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          )),
      title: const Text('Add task'),
      elevation: 0.5,
    );



Widget mainTaskWidget(context) => Padding(
    padding: const EdgeInsets.all(25),
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Form(
                key: formKey,
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(15)),
                  child: defaultTextFormField(
                      controller: titleController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'insert your task!';
                        }

                        return null;
                      },
                      hintName: 'add your task'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              taskDetails(
                  context: context,
                  text: 'Date',
                  insideText: AppCubit.get(context).dateClicked,
                  width: double.infinity,
                  height: 50.0,
                  icon: IconButton(
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2060-12-01'))
                            .then((value) {
                          String newDate = DateFormat.yMd().format(value!);
                          AppCubit.get(context).changeDate(newDate);
                        });
                      },
                      icon: const Icon(Icons.keyboard_arrow_down_sharp))),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  taskDetails(
                      context: context,
                      text: 'Start Time',
                      insideText: AppCubit.get(context).startTimeClicked ??
                          TimeOfDay.now().format(context),
                      height: 50.0,
                      icon: GestureDetector(
                          onTap: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),

                            )
                                .then((value) {
                              AppCubit.get(context)
                                  .changeStartTime(value?.format(context));
                            });
                          },
                          child: const Icon(Icons.keyboard_arrow_down_sharp))),
                  taskDetails(
                      context: context,
                      text: 'End Time',
                      insideText: AppCubit.get(context).endTimeClicked ??
                          TimeOfDay.now().format(context),
                      height: 50.0,
                      icon: GestureDetector(
                          onTap: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((value) {
                              AppCubit.get(context)
                                  .changeEndTime(value?.format(context));
                            });
                          },
                          child: const Icon(Icons.keyboard_arrow_down_sharp))),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              taskDetails(
                  context: context,
                  text: 'Remind',
                  insideText:
                      AppCubit.get(context).remindTimeClicked ?? '10 Min',
                  width: double.infinity,
                  height: 50.0,
                  icon: PopupMenuButton(
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      elevation: 10.0,
                      onSelected: (value) {
                        if (value == 1) {
                          AppCubit.get(context).changeRemindTime('10 Min');
                        }

                        if (value == 2) {
                          AppCubit.get(context).changeRemindTime('15 Min');
                        }

                        if (value == 3) {
                          AppCubit.get(context).changeRemindTime('30 Min');
                        }
                      },
                      itemBuilder: (context) => const [
                            PopupMenuItem(
                              value: 1,
                              child: Text("10 min"),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Text("15 min"),
                            ),
                            PopupMenuItem(
                              value: 3,
                              child: Text("30 min"),
                            ),
                          ])),
            ],
          ),
           const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              CircleAvatar(
                radius: 23,
                backgroundColor: Colors.blue,
                child: GestureDetector(
                  onTap: (){
                    AppCubit.get(context).changeCircleColor();
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppCubit.get(context).blueCircle ? Colors.lightBlue : Colors.white ,
                  ),
                ),
              ),



              const SizedBox(
                width: 30 ,
              ),

              CircleAvatar(
                radius: 23,
                backgroundColor: Colors.red,
                child: GestureDetector(
                  onTap: (){
                    AppCubit.get(context).changeCircleColor();
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppCubit.get(context).redCircle ? Colors.redAccent : Colors.white ,
                  ),
                ),
              ),
            ],
          ),


          SizedBox(
            height: MediaQuery.of(context).size.height / 6.5 ,
          ),


          customButton(
              text: 'Create a Task', color: Colors.green, onPressed: () {

                if(formKey.currentState!.validate()){
                  AppCubit.get(context).insertIntoDatabase(
                    title: titleController.text ,
                    date: AppCubit.get(context).dateClicked,
                    startTime: AppCubit.get(context).startTimeClicked ?? TimeOfDay.now().format(context) ,
                    endTime: AppCubit.get(context).endTimeClicked ?? TimeOfDay.now().format(context) ,
                    remind: AppCubit.get(context).remindTimeClicked ?? '10 Min',
                    color:   AppCubit.get(context).blueCircle ? 'blue' : 'red' ,
                  );

                  AppCubit.get(context).showNotification(titleController.text , AppCubit.get(context).dateClicked ,AppCubit.get(context).startTimeClicked ?? TimeOfDay.now().format(context) );


                  Navigator.pop(context) ;
                }


          }),


        ],
      ),
    ));





Widget taskDetails({context, text, insideText, width, height, icon}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
            width: width,
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  insideText,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                const SizedBox(
                  width: 5,
                ),
                icon,
              ],
            )),
      ],
    );
