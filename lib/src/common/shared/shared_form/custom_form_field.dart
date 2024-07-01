import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.suffixIcon,
    required this.isObscure,
    required this.keyboardType,
    this.validator,
    this.readOnly = false,
    this.inputFormatter,
    this.topPadd = 0,
  });

  final TextEditingController? controller;
  final String labelText, hintText;
  final Widget? suffixIcon;
  final bool isObscure;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatter;
  final double topPadd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topPadd,
        bottom: 5.0,
      ),
      child: TextFormField(
        readOnly: readOnly!,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: isObscure,
        inputFormatters: inputFormatter,
        decoration: InputDecoration(
          // contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          hintText: hintText,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 1.5,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 1.5,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
