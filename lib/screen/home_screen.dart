import 'package:a_fire_base_api/screen/insert_screen.dart';
import 'package:a_fire_base_api/screen/view_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const InsertScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
        title: const Text('FireBase Crud Operation'),
      ),
      body: const ViewUpdateDeleteScreen(),
    );
  }
}
