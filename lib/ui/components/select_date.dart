import 'package:flutter/material.dart';

class SelectDate {
  Future<DateTime?> selectDate(
      {required BuildContext context, required DateTime actualDate}) async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: actualDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    return selected;
  }

  String formatTextDate({required DateTime date, required int typeFormat}) {
    String dateReturn = '';

    /**DD/MM/YYYY**/
    if (typeFormat == 1) {
      dateReturn =
          '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}';
    } else
    /**YYYY-MM-DD**/
    if (typeFormat == 2) {
      dateReturn =
          '${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }

    return dateReturn;
  }
}
