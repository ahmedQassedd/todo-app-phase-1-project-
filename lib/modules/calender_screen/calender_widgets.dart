import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:todo_app/shared/cubit/app_cubit.dart';

AppBar calenderAppBar(context) => AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          )),
      title: const Text('Schedule'),
      elevation: 0.5,
    );

DatePickerController dp = DatePickerController();

DatePicker datePickerMethod() {
  return DatePicker(
    DateTime.now(),
    controller: dp,
    initialSelectedDate: DateTime.now(),
    selectionColor: Colors.green,
    selectedTextColor: Colors.white,
    daysCount: 30,
  );
}

Widget mainCalenderWidget(context) => Padding(
    padding: const EdgeInsets.all(25),
    child: Column(
      children: [
        datePickerMethod(),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.grey[300],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Jiffy().EEEE,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
            child: AppCubit.get(context).allData.isNotEmpty
                ? ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => calenderTaskList(
                        AppCubit.get(context).allData[index], context),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                    itemCount: AppCubit.get(context).allData.length)
                : const Image(image: AssetImage('assets/emptyPage.png'))),
      ],
    ));




var date = DateFormat.yMd().format(DateTime.now());

Widget calenderTaskList(Map model, context) => model['date'] == date
    ? Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
            color: model['color'] == 'blue' ? Colors.blue : Colors.red,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model['startTime'],
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  model['title'],
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w400, color: Colors.white),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                AppCubit.get(context).updateItemFromDateBase(
                    dataName: 'status',
                    dataValue: 'completed',
                    id: model['id']);
              },
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 13,
                  backgroundColor:
                      model['color'] == 'blue' ? Colors.blue : Colors.red,
                  child: model['status'] == 'completed'
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        )
                      : Container(),
                ),
              ),
            ),
          ],
        ),
      )
    : Container();
