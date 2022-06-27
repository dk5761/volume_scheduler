import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:daily_volume_controller/models/schedule.dart';
import 'package:daily_volume_controller/providers/dbDataProvider.dart';
import 'package:daily_volume_controller/utils/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_mode/sound_mode.dart';

class ScheduleTile extends ConsumerStatefulWidget {
  const ScheduleTile({Key? key, required this.item, required this.index})
      : super(key: key);

  final Schedule item;
  final int index;

  @override
  // ignore: library_private_types_in_public_api
  _ScheduleTileState createState() => _ScheduleTileState();
}

class _ScheduleTileState extends ConsumerState<ScheduleTile> {
  late bool isSwitched;

  @override
  void initState() {
    isSwitched = widget.item.active;

    super.initState();
  }

  static void playAlarm(int id) async {
    if (kDebugMode) {
      print(id);
    }
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getString("id") ?? "";
    SoundMode.setSoundMode(setRingerMode(mode));
  }

  void toggleSwitch(bool value) async {
    setState(() {
      isSwitched = value;
    });

    ref.read(dataProvider).updateTheSchedule(
        widget.item.id.toString(), {"active": isSwitched ? 1 : 0});

    if (value == true) {
      await AndroidAlarmManager.periodic(
          const Duration(seconds: 5), widget.item.id!.toInt(), playAlarm,
          startAt: widget.item.time);
    } else {
      await AndroidAlarmManager.cancel(widget.item.id!.toInt());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Colors.white,
        title: Text(
          widget.item.title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            Text(
              convertDateTimeToString(widget.item.time, context),
              softWrap: true,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.item.mode.toString().split('.').last,
              softWrap: true,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            )
          ],
        ),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          Switch(value: isSwitched, onChanged: toggleSwitch),
          GestureDetector(
            child: const Icon(Icons.delete),
            onTap: () {
              if (kDebugMode) {
                print("delete clicked");
              }
            },
          )
        ]),
      ),
    );
  }
}
