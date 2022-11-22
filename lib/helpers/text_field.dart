import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String label;
  const InputField({
    super.key,
    required this.controller,
    required this.label,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          shape: BoxShape.rectangle,
          color: Colors.grey),
      child: TextField(
        textAlign: TextAlign.center,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
