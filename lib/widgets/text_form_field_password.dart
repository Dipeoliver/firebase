import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController _controller;
  final bool PasswordField;
  final TextInputType KeyboardType;
  PasswordTextFormField(
      this.label, this._controller, this.PasswordField, this.KeyboardType,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      obscureText: PasswordField,
      keyboardType: KeyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
        labelText: label,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Informe sua senha!';
        } else if (value.length < 6) {
          return 'Seua senha deve ter no minimo 6 caracteres';
        }
        return null;
      },
    );
  }
}
