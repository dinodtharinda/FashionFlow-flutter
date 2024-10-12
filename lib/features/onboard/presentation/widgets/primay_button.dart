import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPress;
  const PrimaryButton({
    super.key,
    required this.title,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              const Color.fromARGB(255, 255, 255, 255), // Background color
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(50), // Rounded corners with radius 50
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: 32, vertical: 16), // Adjust padding as needed
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Color.fromARGB(
                255, 0, 0, 0), // Text color to contrast with black background
            fontSize: 16, // Adjust font size if needed
          ),
        ),
      ),
    );
  }
}
