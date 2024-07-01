import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.onTap,
    this.onChange,
    this.onEditingComplete,
    this.keyBoardType,
    this.validator,
  }) : super(key: key);

  final String? label;
  final TextEditingController? controller;
  final void Function()? onTap, onEditingComplete;
  final void Function(String)? onChange;
  final TextInputType? keyBoardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyBoardType ?? TextInputType.text,
        decoration: InputDecoration(
          label: Text(label!),
          suffixIcon: IconButton(
            onPressed: onTap,
            icon: const Icon(
              CupertinoIcons.clear_circled,
              size: 30,
            ),
          ),
        ),
        onChanged: onChange,
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}
