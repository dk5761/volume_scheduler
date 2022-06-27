import 'package:daily_volume_controller/utils/data.dart';
import 'package:flutter/cupertino.dart';

class Schedule {
  Schedule({
    this.id,
    required this.time,
    required this.title,
    required this.mode,
    required this.active,
    required this.volume,
  }) {
    id = id ?? UniqueKey().hashCode;
  }

  int? id;
  final DateTime time;
  final String title;
  final RingerMode mode;
  final bool active;
  final int volume;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        time: json["time"],
        title: json["title"],
        mode: json["mode"],
        active: json["active"],
        volume: json["volume"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "title": title,
        "mode": mode,
        "active": active,
        "volume": volume,
      };
}
