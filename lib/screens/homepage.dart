import 'package:daily_volume_controller/screens/new_schedule_page.dart';
import 'package:daily_volume_controller/widgets/schedule_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Volume controller"),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ScheduleTile();
            },
            itemCount: 2,
          )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NewSchedulePage()));
        },
      ),
    );
  }
}
