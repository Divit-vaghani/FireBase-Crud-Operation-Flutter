import 'package:a_fire_base_api/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../single_ton/single_ton.dart';

class SignInWithGoogleProvider extends ChangeNotifier {
  final GoogleSignIn _signIn = GoogleSignIn();
  late GoogleSignInAccount _user;

  GoogleSignInAccount get user => _user;

  Future<void> signWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _signIn.signIn();
    if (googleUser == null) return;

    final GoogleSignInAuthentication authentication =
        await googleUser.authentication;

    final credentials = GoogleAuthProvider.credential(
      idToken: authentication.idToken,
      accessToken: authentication.accessToken,
    );
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credentials);
    Singleton singleton = Singleton();
    singleton.userDoc = userCredential.user!.uid;
    await _createFireStoreCollection(userCredential.user!);
  }

  Future<void> logOut() async {
    await _signIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  Future<void> _createFireStoreCollection(User user) async {
    final data = FirebaseFirestore.instance.collection('Log-in-User');
    await data.doc(user.uid).set(
          UserModel(
                  name: '${user.displayName}',
                  email: '${user.email}',
                  isVerified: '${user.emailVerified}',
                  mobileNo: '${user.phoneNumber}',
                  photoUrl: '${user.photoURL}')
              .toJson(),
        );
  }
}
