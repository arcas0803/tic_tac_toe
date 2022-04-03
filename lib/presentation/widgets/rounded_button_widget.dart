import 'package:flutter/material.dart';

/// Rounded button used across app
class RoundedButtonWidget extends StatelessWidget {
  /// Title of the button
  final String title;

  /// Function to execute on pressed button
  final void Function() onPressed;

  const RoundedButtonWidget({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.red),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
