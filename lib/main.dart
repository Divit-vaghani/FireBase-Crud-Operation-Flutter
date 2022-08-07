import 'package:a_fire_base_api/provider/sign_in_provider.dart';
import 'package:a_fire_base_api/screen/home_screen.dart';
import 'package:a_fire_base_api/screen/sign_in_screen.dart';
import 'package:a_fire_base_api/single_ton/single_ton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInWithGoogleProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firebase Crud',
        home: Scaffold(
          body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                Singleton singleton = Singleton();
                singleton.userDoc = snapshot.data!.uid;
                return const HomeScreen();
              } else {
                return const SignInScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
