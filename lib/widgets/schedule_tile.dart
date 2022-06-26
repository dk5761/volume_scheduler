import 'package:daily_volume_controller/models/schedule.dart';
import 'package:daily_volume_controller/utils/data.dart';
import 'package:daily_volume_controller/utils/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScheduleTile extends StatefulWidget {
  const ScheduleTile({Key? key, required this.item}) : super(key: key);

  final Schedule item;

  @override
  State<ScheduleTile> createState() => _ScheduleTileState();
}

class _ScheduleTileState extends State<ScheduleTile> {
  bool isSwitched = false;

  void toggleSwitch(bool value) {
    setState(() {
      isSwitched = value;
    });
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
