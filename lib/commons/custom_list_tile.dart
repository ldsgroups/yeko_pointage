import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.title,
    required this.subtitle,
    required this.trailingTitle,
    this.hasJoinedFile = false,
    super.key,
    this.trailingSubtitle,
    this.leadingIcon = Icons.person,
    this.onTap,
    this.onLeadingTap,
    this.onLongPress,
    this.color,
    this.bgColor = Colors.black12,
  });

  final String title;
  final String subtitle;
  final String trailingTitle;
  final bool hasJoinedFile;
  final String? trailingSubtitle;
  final void Function()? onTap;
  final void Function()? onLeadingTap;
  final void Function()? onLongPress;
  final IconData? leadingIcon;
  final Color? color;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: GestureDetector(
        onTap: () {
          if (hasJoinedFile) onLeadingTap!();
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                leadingIcon,
                color: color ?? colorScheme.primary,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: hasJoinedFile
                    ? Icon(
                        Icons.file_present_outlined,
                        color: colorScheme.primary,
                        size: 14,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        subtitle.length > 44 ? '${subtitle.substring(0, 44)}...' : subtitle,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: colorScheme.onBackground.withOpacity(0.6),
            ),
      ),
      trailing: trailingSubtitle == null
          ? Text(
              trailingTitle,
              style: TextStyle(
                fontSize: 16,
                color: color ?? colorScheme.primary,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  trailingTitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: color ?? colorScheme.primary,
                  ),
                ),
                Text(trailingSubtitle!),
              ],
            ),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
