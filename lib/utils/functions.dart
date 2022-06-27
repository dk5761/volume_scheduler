import 'package:flutter/material.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

import 'data.dart';

String convertModeToDbString(RingerMode ringer) {
  switch (ringer) {
    case RingerMode.normal:
      return 'normal';
    case RingerMode.silent:
      return 'silent';
    case RingerMode.vibrate:
      return 'vibrate';
    // case RingerMode.unknown:
    //   return 'unknown';
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
    // case 'unknown':
    //   return RingerMode.unknown;
    default:
      return RingerMode.vibrate;
  }
}

String convertDateTimeToString(DateTime dateTime, BuildContext context) {
  return TimeOfDay.fromDateTime(dateTime).format(context).toString();
}

RingerModeStatus setRingerMode(RingerMode ringerMode) {
  switch (ringerMode) {
    case RingerMode.normal:
      return RingerModeStatus.normal;
    case RingerMode.silent:
      return RingerModeStatus.silent;
    case RingerMode.vibrate:
      return RingerModeStatus.vibrate;
    // case RingerMode.unknown:
    //   return 'unknown';
    default:
      return RingerModeStatus.normal;
  }
}
