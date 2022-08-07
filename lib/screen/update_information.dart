import 'package:a_fire_base_api/model/user_information_model.dart';
import 'package:a_fire_base_api/utils/tost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widget/custom_text_field.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key, required this.queryDocumentSnapshot})
      : super(key: key);

  final QueryDocumentSnapshot queryDocumentSnapshot;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final validate = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController rollController = TextEditingController();

  Future<void> updateUserInformation(String id) async {
    final data = FirebaseFirestore.instance.collection('User-Information');
    await data.doc(id).update(
          UserInformation(
            lastname: lastNameController.text,
            name: nameController.text,
            roll: rollController.text,
          ).toJson(),
        );
  }

  @override
  void initState() {
    UserInformation userInformation = UserInformation.fromJson(
        widget.queryDocumentSnapshot.data() as Map<String, dynamic>);
    nameController.text = userInformation.name;
    lastNameController.text = userInformation.lastname;
    rollController.text = userInformation.roll;
    super.initState();
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
          title: const Text('Update User Information'),
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
                          ? await updateUserInformation(
                                  widget.queryDocumentSnapshot.id)
                              .whenComplete(
                                () => Tost.show('User Updated'),
                              )
                              .onError(
                                (error, stackTrace) =>
                                    Tost.show('Unknown Error'),
                              )
                          : null;
                      if (!mounted) return;

                      FocusScope.of(context).unfocus();
                    },
                    child: const Text('Update Information'),
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
