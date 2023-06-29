import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/widgets/main_layout/app_bar.dart';
import 'package:hypertrip/widgets/main_layout/bottom_nav.dart';

class MainLayout extends StatelessWidget {
  final bool showAppBar;
  final bool showBottomNav;
  final Widget body;

  const MainLayout({
    super.key,
    required this.body,
    this.showAppBar = true,
    this.showBottomNav = true,
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode _focusNode = FocusNode();
    final List<BottomBarItem> leftBottomNavItems = [
      BottomBarItem(
        icon: const Icon(Icons.home),
        text: 'Home',
        onPressed: () {
          // Navigator.pushReplacementNamed(context, NearbyPage.routeName);
        },
      ),
      BottomBarItem(
        icon: const Icon(Icons.home),
        text: 'Home',
        onPressed: () {},
      ),
    ];

    final List<BottomBarItem> rightBottomNavItems = [
      BottomBarItem(
        icon: const Icon(Icons.home),
        text: 'Home',
        onPressed: () {},
      ),
      BottomBarItem(
        icon: const Icon(Icons.home),
        text: 'Home',
        onPressed: () {},
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.bgLightColor,
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: showAppBar ? buildAppBar() : null,
      bottomNavigationBar: showBottomNav
          ? BottomNav(
              leftBottomNavItems: leftBottomNavItems,
              rightBottomNavItems: rightBottomNavItems)
          : null,
    );
  }
}
