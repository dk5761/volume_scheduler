import 'package:daily_volume_controller/providers/dbDataProvider.dart';
import 'package:daily_volume_controller/screens/new_schedule_page.dart';
import 'package:daily_volume_controller/widgets/schedule_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(dataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Volume controller",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: provider.items.isNotEmpty
          ? Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ScheduleTile(
                    item: provider.items[index],
                    index: index,
                  );
                },
                itemCount: provider.items.length,
              ))
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const Center(
                child: Text("No Schedules?"),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NewSchedulePage()));
        },
      ),
    );
  }
}
