import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MenuListItem extends StatelessWidget {
  final IconData icon;
  final String titleKey;
  final VoidCallback onTap;

  const MenuListItem({
    super.key,
    required this.icon,
    required this.titleKey,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(titleKey.tr()),
      onTap: onTap,
    );
  }
}
