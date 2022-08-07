import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Crud',
      home: HomeScreen(),
    );
  }
}

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
        title: const Text('Sign With Google'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            GoogleSignIn signIn = GoogleSignIn();
            final googleUser = await signIn.signIn();
            final authentication = await googleUser!.authentication;
            final cre = GoogleAuthProvider.credential(
              idToken: authentication.idToken,
              accessToken: authentication.accessToken,
            );

            final data = await FirebaseAuth.instance.signInWithCredential(cre);

            print(data.additionalUserInfo!.profile);
          },
          child: const Text('Sign With Google'),
        ),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Firebase Crud',
//       debugShowCheckedModeBanner: false,
//       home: Home(),
//     );
//   }
// }
