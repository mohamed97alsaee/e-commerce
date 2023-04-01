import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../helpers/consts.dart';
import '../../../providers/dark_theme_provider.dart';


class DrawerTile extends StatefulWidget {
  const DrawerTile(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onPressed,
      this.withDivider = true})
      : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final bool withDivider;
  @override
  State<DrawerTile> createState() => _DrawerTileState();
}

class _DrawerTileState extends State<DrawerTile> {
  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

    return Column(
      children: [
        ListTile(
          onTap: (() {
            widget.onPressed();
          }),
          leading: FaIcon(
            widget.icon,
            color: themeListener.isDark ? lightWihteColor : darkGreyColor,
          ),
          title: Text(
            widget.title,
            style: TextStyle(
                color: themeListener.isDark ? lightWihteColor : darkGreyColor,
                fontWeight: FontWeight.w600,
                fontSize: 14),
          ),
        ),
        if (widget.withDivider)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 0.2,
              color: themeListener.isDark
                  ? lightWihteColor.withOpacity(0.5)
                  : darkGreyColor.withOpacity(0.5),
            ),
          ),
      ],
    );
  }
}
