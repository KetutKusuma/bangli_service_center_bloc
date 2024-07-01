import 'package:flutter/material.dart';

class CustomFormFieldReadOnly extends StatelessWidget {
  const CustomFormFieldReadOnly({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
  });

  final String? label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        validator: validator,
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          label: Text(label!),
        ),
      ),
    );
  }
}
