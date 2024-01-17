import 'package:flutter/material.dart';

class YesNoButton extends StatelessWidget {
  const YesNoButton({
    super.key,
    required this.text,
    required this.onTap,
    this.withBottomLeftRadius = false,
    this.withBottomRightRadius = false,
  });

  final String text;
  final void Function()? onTap;
  final bool? withBottomLeftRadius;
  final bool? withBottomRightRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Theme.of(context).colorScheme.secondaryContainer,
      splashFactory: InkRipple.splashFactory,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(
          withBottomLeftRadius! ? 12 : 0,
        ),
        bottomRight: Radius.circular(
          withBottomRightRadius! ? 12 : 0,
        ),
      ),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              withBottomLeftRadius! ? 12 : 0,
            ),
            bottomRight: Radius.circular(
              withBottomRightRadius! ? 12 : 0,
            ),
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
