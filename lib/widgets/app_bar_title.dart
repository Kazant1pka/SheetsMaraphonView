import 'package:flutter/material.dart';
import 'package:maraphons/model/colors.dart';
import 'package:maraphons/page/setings_page.dart';

class AppBarTitle extends StatelessWidget implements PreferredSizeWidget {
  const AppBarTitle({
    required this.titleText,
    required this.size,
    required this.height,
    this.isMainAppBar = false,
    super.key,
  });

  final double height;
  final String titleText;
  final int size;
  final bool isMainAppBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: isMainAppBar
          ? [
              Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const SettingsScreen()),
                      );
                    },
                    icon: const Icon(Icons.settings)),
              )
            ]
          : null,
      title: Opacity(
        opacity: isMainAppBar ? 1 : 0.5,
        child: Center(
            child: Text(
          titleText.toUpperCase(),
          style: TextStyle(
            letterSpacing: 5,
            wordSpacing: 10,
            fontFamily: 'PlayfairDisplay',
            fontSize: isMainAppBar ? 48 : 14,
            fontStyle: isMainAppBar ? FontStyle.italic : FontStyle.normal,
            color: AppColors.titleText,
            fontWeight: FontWeight.w900,
          ),
        )),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height / 20);
}
