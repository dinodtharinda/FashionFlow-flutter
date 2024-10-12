import 'package:fashion_flow/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';

class DividerText extends StatelessWidget {
  final String text;
  const DividerText({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        const Expanded(
            child: Divider(
          color: AppPallete.greyColor,
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(
              color: AppPallete.greyColor,
            ),
          ),
        ),
        const Expanded(
            child: Divider(
          color: AppPallete.greyColor,
        )),
      ],
    );
  }
}
