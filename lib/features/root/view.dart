import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hypertrip/features/public/account/view.dart';
import 'package:hypertrip/features/public/chat/chat_page.dart';
import 'package:hypertrip/features/public/current_tour/view.dart';
import 'package:hypertrip/features/public/nearby/view.dart';
import 'package:hypertrip/features/public/page.dart';
import 'package:hypertrip/features/root/cubit.dart';
import 'package:hypertrip/features/tour_guide/activity/view.dart';
import 'package:hypertrip/theme/color.dart';

import '../../generated/resource.dart';

part 'parts/bottom_nav.dart';

class RootPage extends StatefulWidget {
  static const routeName = '/';

  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const CurrentTourPage(),
    // const NearbyPage(),
    const ScheduleScreen(),
    const ChatPageScreen(),
    const ActivityPage(),
    const AccountPage(),
  ];

  void onChangeTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final cubit = BlocProvider.of<RootCubit>(context);
      cubit.load();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNav(
        onChange: onChangeTab,
      ),
    );
  }
}
