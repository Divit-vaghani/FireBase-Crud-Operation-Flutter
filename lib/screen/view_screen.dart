import 'package:a_fire_base_api/model/user_information_model.dart';
import 'package:a_fire_base_api/screen/update_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/tost.dart';

class ViewUpdateDeleteScreen extends StatefulWidget {
  const ViewUpdateDeleteScreen({Key? key}) : super(key: key);

  @override
  State<ViewUpdateDeleteScreen> createState() => _ViewUpdateDeleteScreenState();
}

class _ViewUpdateDeleteScreenState extends State<ViewUpdateDeleteScreen> {
  Stream<QuerySnapshot> getCurrentUserInformation() =>
      FirebaseFirestore.instance.collection("User-Information").snapshots();

  Future<void> deleteData(String id) async => await FirebaseFirestore.instance
      .collection("User-Information")
      .doc(id)
      .delete();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getCurrentUserInformation(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No User Data exist'),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((val) {
                UserInformation userInformation = UserInformation.fromJson(
                  val.data() as Map<String, dynamic>,
                );

                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            UpdateScreen(queryDocumentSnapshot: val),
                      ),
                    );
                  },
                  title: Text(
                      '${userInformation.name} ${userInformation.lastname}'),
                  subtitle: Text(userInformation.roll),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await deleteData(val.id).whenComplete(() {
                        Tost.show('User Data Deleted');
                      });
                    },
                  ),
                );
              }).toList(),
            );
          }
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
