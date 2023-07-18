import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hypertrip/features/public/account/view.dart';
import 'package:hypertrip/features/public/chat/view.dart';
import 'package:hypertrip/features/public/current_tour/view.dart';
import 'package:hypertrip/features/public/emergency/view.dart';
import 'package:hypertrip/features/public/nearby/view.dart';
import 'package:hypertrip/features/tour_guide/activity/view.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../generated/resource.dart';

part 'parts/bottom_nav.dart';

class RootPage extends StatefulWidget {
  static const routeName = '/root';

  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const CurrentTourPage(),
    const NearbyPage(),
    const ChatPage(),
    const ActivityPage(),
    const AccountPage(),
  ];

  void onChangeTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNav(
          onChange: onChangeTab,
        ));
  }
}
