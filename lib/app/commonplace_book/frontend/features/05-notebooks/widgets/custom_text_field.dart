// Flutter Imports
import 'package:flutter/material.dart';



class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.enable,
    this.forceErrorText,
    required this.hintText,
    required this.icon,
    required this.initialValue,
    required this.labelText,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.suffixIcon,
    this.onChanged,
    this.obscureText = false,
    this.readOnly = false,
  });

  final TextEditingController? controller;
  final bool? enable;
  final String? forceErrorText;
  final String hintText;
  final IconData icon;
  final String initialValue;
  final String labelText;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final IconData? suffixIcon;
  final Function(String)? onChanged;
  final bool obscureText;
  final bool readOnly;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}



class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }
  
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  
@override
Widget build(BuildContext context) {
  return 
    Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(40),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextFormField(
          enabled: widget.enable,
          forceErrorText: widget.forceErrorText,
          focusNode: _focusNode,
          controller: widget.controller,
          initialValue: widget.initialValue,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          obscureText: widget.obscureText,
          onChanged: widget.onChanged,
          readOnly: widget.readOnly,
          decoration: InputDecoration(
            
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: _focusNode.hasFocus ? Theme.of(context).primaryColor : Colors.black87,
            ),
            
            labelText: widget.labelText,
            hintText: widget.hintText,
            prefixIcon: Icon(widget.icon),
            suffixIcon: widget.suffixIcon != null ? Icon(widget.suffixIcon) : null,
            filled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(borderSide: BorderSide.none),
            
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black12, width: 1.5)
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black12, width: 2.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2.5),
            ),
            
            counter: _focusNode.hasFocus ? null : const SizedBox.shrink(),
            
            
          ),
        ),
      );
  }
}