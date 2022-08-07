import 'package:a_fire_base_api/provider/sign_in_provider.dart';
import 'package:a_fire_base_api/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: double.maxFinite,
          height: 45.0,
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
            ),
            onPressed: () async {
              await Provider.of<SignInWithGoogleProvider>(context,
                      listen: false)
                  .signWithGoogle();
              if (!mounted) return;

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                FaIcon(FontAwesomeIcons.google, color: Colors.red),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  'Sign With Google',
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
