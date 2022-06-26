import 'package:daily_volume_controller/providers/dbDataProvider.dart';
import 'package:daily_volume_controller/utils/data.dart';
import 'package:daily_volume_controller/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/functions.dart';

class NewSchedulePage extends ConsumerStatefulWidget {
  const NewSchedulePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NewSchedulePageState createState() => _NewSchedulePageState();
}

class _NewSchedulePageState extends ConsumerState<NewSchedulePage> {
  TimeOfDay selectedTime = TimeOfDay.now();
  late final TextEditingController _textEditingController =
      TextEditingController();
  RingerMode _ringerMode = RingerMode.normal;
  String title = "default";
  double _currentSliderValue = 0;

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

  DateTime _convertToDateTime() {
    final now = DateTime.now();
    return DateTime(
        now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(dataProvider);

    Future<void> saveToDb() async {
      provider.addSchedule(title, _convertToDateTime(), _ringerMode, true,
          _currentSliderValue.toInt());
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          "New Schedule",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black54)),
                onPressed: () {
                  _selectTime(context);
                },
                child: const Text(
                  "Choose Time",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(selectedTime.format(context).toString()),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Title",
            style: TextStyle(fontSize: 22),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            onChanged: (value) {
              title = value;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Ringer Mode",
            style: TextStyle(fontSize: 22),
          ),
          const SizedBox(
            height: 10,
          ),
          DropdownButton<RingerMode>(
              value: _ringerMode,
              items: RingerMode.values.map((RingerMode e) {
                return DropdownMenuItem(
                    value: e, child: Text(e.name.toString()));
              }).toList(),
              onChanged: (RingerMode? value) {
                setState(() {
                  _ringerMode = value!;
                });
              }),
          const SizedBox(
            height: 10,
          ),
          _ringerMode == RingerMode.normal
              ? Slider(
                  value: _currentSliderValue,
                  max: 100,
                  divisions: 10,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                )
              : const SizedBox(),
          TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black54)),
            onPressed: saveToDb,
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          )
        ]),
      ),
    );
  }
}
