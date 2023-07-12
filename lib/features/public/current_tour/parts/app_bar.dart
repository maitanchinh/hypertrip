part of '../view.dart';

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.primaryColor,
    title: Row(
      children: const [
        Text(
          AppConstant.APP_NAME,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(NotificationScreen.routeName);
        },
        icon: const Icon(Icons.notifications, color: Colors.white),
      ),
    ],
  );
}
