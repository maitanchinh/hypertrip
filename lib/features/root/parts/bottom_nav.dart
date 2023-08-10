part of '../view.dart';

class BottomNav extends StatefulWidget {
  final void Function(int) onChange;

  const BottomNav({
    super.key,
    required this.onChange,
  });

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
      widget.onChange(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.textGreyColor,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 30,
        onTap: onTap,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Resource.iconsHome,
                height: 20,
                color: AppColors.textGreyColor,
              ),
              activeIcon: SvgPicture.asset(
                Resource.iconsHome,
                height: 20,
                color: AppColors.primaryColor,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Resource.iconsLocationArrow,
                height: 20,
                color: AppColors.textGreyColor,
              ),
              activeIcon: SvgPicture.asset(
                Resource.iconsLocationArrow,
                height: 20,
                color: AppColors.primaryColor,
              ),
              label: "Schedule"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Resource.iconsMessage,
                height: 20,
                color: AppColors.textGreyColor,
              ),
              activeIcon: SvgPicture.asset(
                Resource.iconsMessage,
                height: 20,
                color: AppColors.primaryColor,
              ),
              label: "Chat"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Resource.iconsPersionWalking,
                height: 20,
                color: AppColors.textGreyColor,
              ),
              activeIcon: SvgPicture.asset(
                Resource.iconsPersionWalking,
                height: 20,
                color: AppColors.primaryColor,
              ),
              label: "Activity"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Resource.iconsUser,
                height: 20,
                color: AppColors.textGreyColor,
              ),
              activeIcon: SvgPicture.asset(
                Resource.iconsUser,
                height: 20,
                color: AppColors.primaryColor,
              ),
              label: "Account"),
        ],
      ),
    );
  }
}
