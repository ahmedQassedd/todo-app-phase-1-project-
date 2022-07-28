import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



Widget customButton({
  double height = 50.0,
  double width = double.infinity,
  required String text,
  required Color color,
  required Function onPressed,
}) =>
    Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: color,
      ),
      child: MaterialButton(
          onPressed: () {
            onPressed();
          },
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          )),
    );







Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?)? validate,
  required String hintName,

}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validate,
      decoration: InputDecoration(
        hintText: hintName,
        border: InputBorder.none ,
      ),

    );


void navigateTo({required BuildContext context, required Widget widget}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));











ThemeData lightingTheme() => ThemeData(

  primarySwatch: Colors.green,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    actionsIconTheme: IconThemeData(color: Colors.black),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark),
    backgroundColor: Colors.white,
    elevation: 0.0,

    titleTextStyle: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
  ),
);



// DateTime toDateTime(String dateStr , context) {
//
//   DateTime outputDate = DateFormat('yyyy/MM/dd hh:mm a').parse(dateStr);
//   print(outputDate);
//   return outputDate;
//
//
// }
//
//
// toDateTime(
// '${AppCubit.get(context).dateClicked} ${AppCubit.get(context).startTimeClicked ?? TimeOfDay.now().format(context)}'
// , context);
