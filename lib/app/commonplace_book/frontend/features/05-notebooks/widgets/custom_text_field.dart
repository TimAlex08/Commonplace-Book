// Flutter Imports
import 'package:flutter/material.dart';



class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.icon,
    required this.labelText,
    this.minLines,
    this.maxLines,
    this.suffixIcon,
    this.onChanged,
    required this.obscureText,
  });

  final TextEditingController? controller;
  final String hintText;
  final IconData icon;
  final String labelText;
  final int? minLines;
  final int? maxLines;
  final IconData? suffixIcon;
  final Function(String)? onChanged;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        hintText: hintText,
        labelText: labelText,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon != null
          ? Icon(suffixIcon)
          : null,

      ),
    );
  }
}