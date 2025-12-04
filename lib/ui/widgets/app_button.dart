import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; 

  const AppButton({super.key, required this.text, this.onPressed}); 

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 6,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}