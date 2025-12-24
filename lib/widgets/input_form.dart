import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;
  final FormFieldValidator<String>? validator;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final EdgeInsetsGeometry padding;
  final double radius;
  final TextInputAction textInputAction;

  const FormInput({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.validator,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.radius = 12,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    final defaultFill = fillColor ?? Colors.grey.shade100;
    final defaultBorder = borderColor ?? Colors.grey.shade400;
    final defaultFocused = focusedBorderColor ?? Colors.grey.shade700;

    return Padding(
      padding: padding,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        textInputAction: textInputAction,
        validator: validator,

        style: TextStyle(color: Colors.grey.shade900, fontSize: 16),

        decoration: InputDecoration(
          label: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),

          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 15),

          filled: true,
          fillColor: defaultFill,

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: defaultBorder, width: 1),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: defaultBorder, width: 1),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: defaultFocused, width: 1.2),
          ),
        ),
      ),
    );
  }
}
