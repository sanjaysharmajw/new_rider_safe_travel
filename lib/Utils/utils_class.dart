

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyUtils{
  static TextStyle? headline(BuildContext context){
    return Theme.of(context).textTheme.headline5;
  }

  static Future<DateTime?> selectDate(BuildContext context,DateTime selectedDate) async {
    DateTime? picked;
    picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    return picked;
  }

  static String getFormattedTimeEvent(int time) {
    DateFormat newFormat =  DateFormat("h:mm a");
    return newFormat.format(DateTime.fromMillisecondsSinceEpoch(time));
  }

}