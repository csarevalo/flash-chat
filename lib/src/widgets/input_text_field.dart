import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final int? maxLength;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;
  final String? hintText;
  final String? labelText;
  final TextAlign textAlign;
  final bool obscureText;
  final TextInputType? keyboardType;

  const InputTextField({
    super.key,
    this.maxLength,
    this.controller,
    this.onEditingComplete,
    this.onSubmitted,
    this.onChanged,
    this.hintText = 'Enter value',
    this.labelText = 'Label',
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  late bool _visibility;

  @override
  void initState() {
    super.initState();
    _visibility = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: SizedBox(
        width: 300,
        child: TextField(
          maxLength: widget.maxLength,
          controller: widget.controller,
          onEditingComplete: widget.onEditingComplete,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          textAlign: widget.textAlign,
          textAlignVertical: TextAlignVertical.center,
          obscureText: widget.obscureText && _visibility,
          decoration: InputDecoration(
            hintText: widget.hintText,
            labelText: widget.labelText,
            alignLabelWithHint: true,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: widget.obscureText
                  ? IconButton(
                      //TODO: make only Icon button a state widget
                      iconSize: 20,
                      onPressed: () {
                        setState(() {
                          _visibility = !_visibility;
                        });
                      },
                      icon: Icon(
                        _visibility ? Icons.visibility_off : Icons.visibility,
                      ),
                    )
                  : null,
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.tertiaryContainer,
            contentPadding: const EdgeInsets.fromLTRB(18.0, 8.0, 16.0, 8.0),
            border: const OutlineInputBorder(),
          ),
          keyboardType: widget.keyboardType ?? TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
        ),
      ),
    );
  }
}
