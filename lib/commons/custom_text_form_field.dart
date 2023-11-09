import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required TextEditingController controller,
    required this.size,
    super.key,
    this.labelText,
    this.inputFormatters,
    this.isBordered = true,
    this.obscureText = false,
    this.validator,
    this.onFieldSubmitted,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
  }) : _controller = controller;

  final String? labelText;
  final TextEditingController _controller;
  final Size size;
  final bool isBordered;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      validator: validator,
      obscureText: obscureText,
      onTapOutside: (p0) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        labelText: labelText,
        border: isBordered ? const OutlineInputBorder() : InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
          vertical: size.width * 0.035,
          horizontal: isBordered ? size.width * 0.035 : 0,
        ),
      ),
    );
  }
}
