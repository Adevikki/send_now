import 'package:flutter/material.dart';
import 'package:send_now_test/core/utils/colors.dart';

class CustomFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final EdgeInsetsGeometry? padding;
  final TextStyle? hintStyle;
  final IconData? prefixIcon;
  final double radius;
  final double borderWidth;
  final Color borderColor;
  final double fontSize;
  final Color textColor;
  final TextInputType keyboardType;
  final bool obscureText;
  final InputBorder noBorder;
  final FormFieldValidator<String>? validateFunction;

  const CustomFormField({
    Key? key,
    required this.controller,
    this.labelText,
    this.prefixIcon,
    this.radius = 10.0,
    this.borderWidth = 1.0,
    this.borderColor = Colors.grey,
    this.fontSize = 16.0,
    this.textColor = Colors.black,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.noBorder,
    this.validateFunction,
    this.hintText,
    this.hintStyle,
    this.padding,
  }) : super(key: key);

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleY: 1.1,
      child: TextFormField(
        validator: widget.validateFunction != null
            ? widget.validateFunction!
            : (value) {
                return null;
              },

        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        style: TextStyle(
          fontSize: widget.fontSize,
          color: widget.textColor,
        ),
        decoration: InputDecoration(
          contentPadding: widget.padding ?? const EdgeInsets.all(0),
          labelText: widget.labelText,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ??
              Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 12,
                    color: SendNowColors.grey.shade400,
                  ),
          // prefixIcon: Icon(prefixIcon),
          border: widget.noBorder,
        ),
        // validator: validator,
      ),
    );
  }
}
