import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateSelectorForm extends StatelessWidget {
  const DateSelectorForm({
    super.key,
    required this.controller,
    required this.label,
    required this.onTap,
    required this.onPress,
    this.validator,
  });

  final TextEditingController? controller;
  final String? label;
  final void Function()? onTap, onPress;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: controller!.value.text.isEmpty
              ? const Icon(
                  CupertinoIcons.calendar_circle_fill,
                  size: 30,
                )
              : IconButton(
                  onPressed: onPress,
                  icon: const Icon(
                    CupertinoIcons.xmark_circle_fill,
                    size: 30,
                  ),
                ),
        ),
        onTap: onTap,
      ),
    );
  }
}
