import 'package:fashion_flow/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final String hintText;
  final IconData? icon;
  final TextEditingController controller;
  final Function(String)? onSubmit;

  const SearchField({
    super.key,
    required this.hintText,
    required this.controller,
    this.icon,
    this.onSubmit,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: widget.onSubmit,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.icon != null
            ? Icon(
                widget.icon,
                color: AppPallete.greyColor,
              )
            : null,
        suffixIcon: IconButton(
          icon: const Icon(
            Icons.clear,
            color: AppPallete.greyColor,
          ),
          onPressed: () {
            widget.controller.clear();
          },
        ),
      ),
      style: TextStyle(
        color: Theme.of(context).primaryColorDark,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.2,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "${widget.hintText} is missing!";
        }
        return null;
      },
    );
  }
}
