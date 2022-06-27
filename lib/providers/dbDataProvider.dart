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

  void addSchedule(
      String title, DateTime dt, RingerMode ringer, bool active, int volume) {
    final newSchedule = Schedule(
        title: title, time: dt, mode: ringer, active: active, volume: volume);
    _items.add(newSchedule);
    notifyListeners();
    ref.read(dbProvider).insert({
      'id': newSchedule.id.toString(),
      'title': newSchedule.title,
      'time': newSchedule.time.toString(),
      'mode': convertModeToDbString(ringer),
      'active': active ? 1 : 0,
      'volume': volume
    });
  }

  Future<void> fetchAndSetData() async {
    final dataList = await ref.read(dbProvider).getData();
    _items = dataList.map((item) {
      return Schedule(
          id: item["id"],
          title: item['title'],
          mode: convertDbModeToRingerMode(item['mode']),
          time: DateFormat("yyyy-MM-dd hh:mm:ss").parse(item['time']),
          volume: item["volume"],
          active: item["active"] == 0 ? false : true);
    }).toList();
    notifyListeners();
  }

  Future<void> updateTheSchedule(String id, Map<String, dynamic> data) async {
    return await ref.read(dbProvider).update(id, data);
  }
}
