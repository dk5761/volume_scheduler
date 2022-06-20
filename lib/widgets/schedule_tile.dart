import 'package:flutter/material.dart';

class ScheduleTile extends StatefulWidget {
  const ScheduleTile({Key? key}) : super(key: key);

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
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      tileColor: Colors.white,
      title: const Text(
        "Office",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      subtitle: const Text(
        "datatime",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      trailing: Switch(value: isSwitched, onChanged: toggleSwitch),
    );
  }
}
