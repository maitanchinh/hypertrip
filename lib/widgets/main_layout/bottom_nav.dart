import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
    required this.leftBottomNavItems,
    required this.rightBottomNavItems,
  });

  final List<BottomBarItem> leftBottomNavItems;
  final List<BottomBarItem> rightBottomNavItems;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 10,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...leftBottomNavItems.map(
                  (e) => MaterialButton(
                    onPressed: e.onPressed,
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        e.icon,
                        Text(e.text),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...rightBottomNavItems.map(
                  (e) => MaterialButton(
                    onPressed: e.onPressed,
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        e.icon,
                        Text(e.text),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BottomBarItem {
  final Icon icon;
  final String text;
  final void Function() onPressed;

  BottomBarItem(
      {required this.icon, required this.text, required this.onPressed});
}
