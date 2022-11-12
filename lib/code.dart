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
