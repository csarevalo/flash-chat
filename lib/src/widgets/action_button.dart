import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final ButtonColorTheme buttonTheme;
  // final Color? backgroundColor;
  // final Color? foregroundColor;
  const ActionButton({
    super.key,
    required this.text,
    this.onPressed,
    this.buttonTheme = ButtonColorTheme.dark,
    // this.backgroundColor,
    // this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    late Color backgroundColor;
    late Color foregroundColor;
    switch (buttonTheme) {
      case ButtonColorTheme.light:
        backgroundColor = Theme.of(context).colorScheme.primary;
        foregroundColor = Theme.of(context).colorScheme.onPrimary;
      case ButtonColorTheme.dark:
        backgroundColor = Theme.of(context).colorScheme.primaryContainer;
        foregroundColor = Theme.of(context).colorScheme.onPrimaryContainer;
      default:
        // Choose ButtonColorTheme based on app brightness
        if (Theme.of(context).brightness == Brightness.light) {
          // Use ButtonColorTheme.light
          backgroundColor = Theme.of(context).colorScheme.primary;
          foregroundColor = Theme.of(context).colorScheme.onPrimary;
        } else {
          // Use ButtonColorTheme.dark
          backgroundColor = Theme.of(context).colorScheme.primaryContainer;
          foregroundColor = Theme.of(context).colorScheme.onPrimaryContainer;
        }
    }
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        fixedSize: const Size(300, 36.0),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15.0),
      ),
    );
  }
}

/// Used to select the button background and forground color
enum ButtonColorTheme {
  /// Use the light button theme
  light,

  /// Use the dark button theme
  dark,

  /// Use the default button theme
  none,
}
