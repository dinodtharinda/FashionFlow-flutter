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
          backgroundColor: Theme.of(context).primaryColorDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          splashFactory: InkRipple.splashFactory,
          
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).primaryColorLight,
            letterSpacing: 1.2
          ),
        ),
      ),
    );
  }
}
