import 'package:flutter/material.dart';

class MessageTextBox extends StatelessWidget {
  final int? maxLength;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onSend;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;

  const MessageTextBox({
    super.key,
    this.maxLength,
    this.controller,
    this.onChanged,
    this.onSend,
    this.onEditingComplete,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: TextField(
        controller: controller,
        maxLength: maxLength,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: 'Message',
          labelText: 'Message',
          alignLabelWithHint: true,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: onSend,
              icon: const Icon(Icons.send),
              iconSize: 20,
              alignment: Alignment.centerRight,
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(18.0, 8.0, 16.0, 8.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
        ),
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
