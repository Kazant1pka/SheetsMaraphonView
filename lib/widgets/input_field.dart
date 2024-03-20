import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.textEditingController,
    required this.icon,
    required this.text,
    super.key,
  });

  final TextEditingController textEditingController;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: text,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        suffixIcon: IconButton(
          onPressed: textEditingController.clear,
          icon: const Icon(Icons.clear),
        ),
      ),
    );
  }
}
