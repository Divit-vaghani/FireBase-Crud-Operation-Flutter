import 'package:a_fire_base_api/screen/about_screen.dart';
import 'package:a_fire_base_api/screen/insert_screen.dart';
import 'package:a_fire_base_api/screen/sign_in_screen.dart';
import 'package:a_fire_base_api/screen/view_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/sign_in_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          ),
          IconButton(
            onPressed: () async {
              await Provider.of<SignInWithGoogleProvider>(context,
                      listen: false)
                  .logOut()
                  .whenComplete(
                    () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    ),
                  );
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(),
                ),
              );
            },
            icon: const Icon(Icons.person),
          )
        ],
        title: const Text('FireBase User'),
      ),
      body: const ViewUpdateDeleteScreen(),
    );
  }
}
