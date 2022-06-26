import 'package:daily_volume_controller/utils/data.dart';

class Schedule {
  Schedule({
    required this.time,
    required this.title,
    required this.mode,
  });

  final DateTime time;
  final String title;
  final RingerMode mode;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        time: json["time"],
        title: json["title"],
        mode: json["mode"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "title": title,
        "mode": mode,
      };
}
