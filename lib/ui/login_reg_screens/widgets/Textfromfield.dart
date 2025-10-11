import 'package:flutter/material.dart';

class textfromfield extends StatelessWidget {
  const textfromfield({super.key, this.icon, this.text});

  final icon;
  final text;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: text,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
