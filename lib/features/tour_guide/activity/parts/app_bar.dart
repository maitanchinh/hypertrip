part of '../view.dart';

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    leading: BackButton(onPressed: () {
      Navigator.of(context).pop();
    }),
    title: Text(
      label_activity,
      // color white
      style:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
    ),
  );
}
