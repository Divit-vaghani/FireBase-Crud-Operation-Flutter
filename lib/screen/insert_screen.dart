import 'package:a_fire_base_api/model/user_information_model.dart';
import 'package:a_fire_base_api/utils/tost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../single_ton/single_ton.dart';
import '../widget/custom_text_field.dart';

class InsertScreen extends StatefulWidget {
  const InsertScreen({Key? key}) : super(key: key);

  @override
  State<InsertScreen> createState() => _InsertScreenState();
}

class _InsertScreenState extends State<InsertScreen> {
  final validate = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController rollController = TextEditingController();

  Future<void> sendUserInformation() async {
    Singleton singleton = Singleton();
    final data = FirebaseFirestore.instance.collection("Log-in-User");
    final userInfo = data.doc(singleton.userDoc).collection("User-Information");

    await userInfo.add(
      UserInformation(
        lastname: lastNameController.text,
        name: nameController.text,
        roll: rollController.text,
      ).toJson(),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    rollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Insert User Information'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: validate,
            child: Column(
              children: [
                CustomTextField(
                  autoFocus: true,
                  controller: nameController,
                  name: 'Name',
                  validator: (val) {
                    return val == '' ? 'required' : null;
                  },
                ),
                CustomTextField(
                  controller: lastNameController,
                  name: 'Last Name',
                  validator: (val) {
                    return val == '' ? 'required' : null;
                  },
                ),
                CustomTextField(
                  controller: rollController,
                  name: 'Current Roll',
                  validator: (val) {
                    return val == '' ? 'required' : null;
                  },
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  width: double.maxFinite,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      validate.currentState!.validate() != false
                          ? await sendUserInformation()
                              .whenComplete(
                                () => Tost.show('User Created'),
                              )
                              .onError(
                                (error, stackTrace) =>
                                    Tost.show('Unknown Error'),
                              )
                          : null;
                      if (!mounted) return;

                      FocusScope.of(context).unfocus();
                    },
                    child: const Text('Send Information'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
