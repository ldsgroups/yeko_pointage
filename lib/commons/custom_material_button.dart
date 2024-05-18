import 'package:flutter/material.dart';

enum IconPosition { left, right }

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    super.key,
    required this.text,
    this.icon,
    this.isLoading = false,
    this.isInverted = false,
    this.iconPosition = IconPosition.left,
    required this.onPressed,
  }); // Enforce required onPressed

  final String text;
  final IconData? icon;
  final bool isLoading;
  final bool isInverted;
  final IconPosition iconPosition;
  final void Function() onPressed; // Make onPressed non-nullable

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: isInverted ? colorScheme.inverseSurface : colorScheme.secondary,
      textColor: isInverted ? colorScheme.onTertiary : colorScheme.onSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onPressed: isLoading ? null : onPressed, // Ternary for disabled state
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            _buildIcon(context, icon, iconPosition == IconPosition.left),
          if (icon != null) const SizedBox(width: 8),
          _buildContent(context, isLoading, text),
          if (icon != null) const SizedBox(width: 8),
          if (icon != null)
            _buildIcon(context, icon, iconPosition == IconPosition.right),
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext ctx, IconData? icon, bool show) {
    return Offstage(
      offstage: !show,
      child: Icon(
        icon,
        color: Theme.of(ctx).colorScheme.onSecondary,
        size: 24,
      ),
    );
  }

  Widget _buildContent(BuildContext ctx, bool isLoading, String text) {
    return isLoading
        ? CircularProgressIndicator(
            color: Theme.of(ctx).colorScheme.onSecondary,
          )
        : Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          );
  }
}
