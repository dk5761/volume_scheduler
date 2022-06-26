import 'dart:io'; // because we are using File in here

import 'package:daily_volume_controller/models/schedule.dart';
import 'package:daily_volume_controller/utils/data.dart';
import 'package:daily_volume_controller/utils/db_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../utils/functions.dart';

final dataProvider = ChangeNotifierProvider<DataProvider>((ref) {
  return DataProvider(ref);
});

class DataProvider with ChangeNotifier {
  final Ref ref;
  List<Schedule> _items = [];

  DataProvider(this.ref) {
    fetchAndSetData();
  }

  List<Schedule> get items => [..._items];

  void addSchedule(String title, DateTime dt, RingerMode ringer) {
    final newSchedule = Schedule(title: title, time: dt, mode: ringer);
    _items.add(newSchedule);
    notifyListeners();
    ref.read(dbProvider).insert({
      'title': newSchedule.title,
      'dt': newSchedule.time.toString(),
      'mode': convertModeToDbString(ringer)
    });
  }

  Future<void> fetchAndSetData() async {
    final dataList = await ref.read(dbProvider).getData();
    _items = dataList.map((item) {
      print(item);
      return Schedule(
          title: item['title'],
          mode: convertDbModeToRingerMode(item['mode']),
          time: DateFormat("yyyy-MM-dd hh:mm:ss").parse(item['dt']));
    }).toList();
    notifyListeners();
  }
}
