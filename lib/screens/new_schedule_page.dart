import 'package:daily_volume_controller/utils/data.dart';
import 'package:flutter/material.dart';

class NewSchedulePage extends StatefulWidget {
  const NewSchedulePage({Key? key}) : super(key: key);

  @override
  State<NewSchedulePage> createState() => _NewSchedulePageState();
}

class _NewSchedulePageState extends State<NewSchedulePage> {
  TimeOfDay selectedTime = TimeOfDay.now();
  late TextEditingController _textEditingController = TextEditingController();
  RingerMode _ringerMode = RingerMode.normal;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Scheduler"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  _selectTime(context);
                },
                child: const Text("Choose Time"),
              ),
              const SizedBox(
                width: 20,
              ),
              Text("${selectedTime.hour}:${selectedTime.minute}"),
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
              print(value);
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
          ElevatedButton(onPressed: () {}, child: Text("Save"))
        ]),
      ),
    );
  }
}
