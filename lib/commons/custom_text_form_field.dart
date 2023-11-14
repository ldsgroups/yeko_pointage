import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.hintText,
    required TextEditingController controller,
    super.key,
    this.validator,
    this.keyboardType,
    this.enabled = true,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
  }) : _controller = controller;

  final String hintText;
  final TextEditingController _controller;
  final bool enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextFormField(
        validator: validator,
        controller: _controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        onTapOutside: (p0) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          enabled: enabled,
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
        ),
      ),
    );
  }
}
