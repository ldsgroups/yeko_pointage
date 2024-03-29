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
    this.onPressed,
  });

  final String text;
  final IconData? icon;
  final bool isLoading;
  final bool isInverted;
  final IconPosition iconPosition;
  final void Function()? onPressed;

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
      onPressed: isLoading ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null && iconPosition == IconPosition.left)
            Icon(
              icon,
              color: colorScheme.onSecondary,
              size: 24,
            ),
          if (icon != null && iconPosition == IconPosition.left)
            const SizedBox(width: 8),
          if (isLoading)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CircularProgressIndicator(
                color: colorScheme.onSecondary,
              ),
            )
          else
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (icon != null && iconPosition == IconPosition.right)
            const SizedBox(width: 8),
          if (icon != null && iconPosition == IconPosition.right)
            Icon(
              icon,
              color: colorScheme.onSecondary,
              size: 24,
            ),
        ],
      ),
    );
  }
}
