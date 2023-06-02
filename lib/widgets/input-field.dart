import 'package:flutter/material.dart';
import '../text_style.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    required this.icon,
    required this.hint,
    required this.inputType,
    this.inputAction,
    required this.obscure,
    required this.controller,
    super.key,
  });

  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction? inputAction;
  final bool obscure;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600]?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
              border: InputBorder.none,
              hintText: hint,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              hintStyle: kBodyText),
          obscureText: obscure,
          style: kBodyText,
          keyboardType: inputType,
          textInputAction: inputAction,
        ),
      ),
    );
  }
}
