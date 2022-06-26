import 'package:flutter/material.dart';

import 'data.dart';

String convertModeToDbString(RingerMode ringer) {
  switch (ringer) {
    case RingerMode.normal:
      return 'normal';
    case RingerMode.silent:
      return 'silent';
    case RingerMode.vibrate:
      return 'vibrate';
    case RingerMode.unknown:
      return 'unknown';
    default:
      return 'vibrate';
  }
}

RingerMode convertDbModeToRingerMode(String ringer) {
  switch (ringer) {
    case "normal":
      return RingerMode.normal;
    case 'silent':
      return RingerMode.silent;
    case 'vibrate':
      return RingerMode.vibrate;
    case 'unknown':
      return RingerMode.unknown;
    default:
      return RingerMode.vibrate;
  }
}

String convertDateTimeToString(DateTime dateTime, BuildContext context) {
  return TimeOfDay.fromDateTime(dateTime).format(context).toString();
}
