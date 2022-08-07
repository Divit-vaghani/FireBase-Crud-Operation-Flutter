import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.name,
      this.validator,
      this.controller,
      this.autoFocus = false})
      : super(key: key);

  final String name;
  final String? Function(String? val)? validator;
  final TextEditingController? controller;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: TextFormField(
        autofocus: autoFocus,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          labelText: name,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
