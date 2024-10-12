import 'package:flutter/material.dart';

class AuthOptionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  const AuthOptionButton({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
