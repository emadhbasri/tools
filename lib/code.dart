import 'package:flutter/material.dart';

bool isInRange({
  DateTime? start,
  DateTime? end,
  DateTimeRange? range,
  required DateTime date,
}) {
  if (start != null && end != null) {
    if ((date.isAfter(start) || date.isAtSameMomentAs(start)) &&
        (date.isBefore(end) || date.isAtSameMomentAs(end))) {
      return true;
    }
  }
  if (range != null) {
    if ((date.isAfter(range.start) || date.isAtSameMomentAs(range.start)) &&
        (date.isBefore(range.end) || date.isAtSameMomentAs(range.end))) {
      return true;
    }
  }
  return false;
}

String makeCount(int num) {
  if (num < 1000) {
    return num.toString();
  } else if (num < 1000000) {
    return '${(num ~/ 1000)}k';
  } else {
    return '${(num ~/ 1000000)}m';
  }
}

// extension ToolsList on List {
//   bool containsWhere<E>(bool test(E element)) {
//     int index = this.indexWhere(test);
//     if (index == -1)
//       return false;
//     else
//       return true;
//   }
// }
