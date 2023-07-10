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
        unselectedItemColor: AppColors.textGreyColor  ,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 30,
        onTap: onTap,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.near_me), label: "Nearby"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(
              icon: Icon(Icons.emergency), label: "Activity"),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle_sharp), label: "Account"),
        ],
      ),
    );
  }
}
