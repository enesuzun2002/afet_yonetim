import 'package:flutter/material.dart';

import '../../../constants.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String?) validator;
  final TextInputType? keyboardType;
  final Widget? label;
  final Widget? prefixIcon;
  final AutovalidateMode? autovalidateMode;
  final double? topPadding;
  final double? bottomPadding;
  const CustomTextFormField({
    super.key,
    this.controller,
    required this.validator,
    this.keyboardType,
    this.label,
    this.prefixIcon,
    this.autovalidateMode,
    this.topPadding,
    this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (topPadding != null)
          SizedBox(
            height: topPadding,
          ),
        TextFormField(
          controller: controller,
          validator: (value) => validator(value),
          textInputAction: TextInputAction.next,
          keyboardType: keyboardType,
          autovalidateMode: autovalidateMode,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade300,
            isDense: true,
            label: label,
            prefixIcon: prefixIcon,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Constants.kDefaultRadius),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Constants.kDefaultRadius),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        if (bottomPadding != null)
          SizedBox(
            height: bottomPadding,
          ),
      ],
    );
  }
}
