import 'package:a_fire_base_api/model/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../single_ton/single_ton.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  Stream<DocumentSnapshot<Map<String, dynamic>>> userDetails() {
    Singleton singleton = Singleton();
    final data = FirebaseFirestore.instance.collection("Log-in-User");
    return data.doc(singleton.userDoc).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('User Details'),
      ),
      body: StreamBuilder(
        stream: userDetails(),
        builder: (context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            UserModel userModel = UserModel.fromJson(snapshot.data!.data()!);

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 25.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      height: 125.0,
                      width: 125.0,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: userModel.photoUrl,
                        useOldImageOnUrlChange: false,
                        cacheKey: userModel.photoUrl,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                          value: downloadProgress.progress,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Name'),
                    subtitle: Text(userModel.name),
                  ),
                  ListTile(
                    title: const Text('Email'),
                    subtitle: Text(userModel.email),
                  ),
                  ListTile(
                    title: const Text('Phone No'),
                    subtitle: Text(userModel.mobileNo == 'null'
                        ? 'Not Available'
                        : userModel.mobileNo),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
