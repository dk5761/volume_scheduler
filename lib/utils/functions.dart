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

    default:
      return RingerMode.vibrate;
  }
}

String convertDateTimeToString(DateTime dateTime, BuildContext context) {
  return TimeOfDay.fromDateTime(dateTime).format(context).toString();
}

RingerModeStatus setRingerMode(String ringerMode) {
  switch (ringerMode) {
    case "normal":
      return RingerModeStatus.normal;
    case 'silent':
      return RingerModeStatus.silent;
    case 'vibrate':
      return RingerModeStatus.vibrate;

    default:
      return RingerModeStatus.normal;
  }
}
