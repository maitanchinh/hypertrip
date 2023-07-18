part of '../view.dart';

AppBar _buildAppBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    // title: const Row(
    //   children: [
    //     Text(
    //       AppConstant.APP_NAME,
    //       style: TextStyle(
    //         color: Colors.white,
    //         fontSize: 20,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //   ],
    // ),
    actions: [
      ActionButton(
        icon: Resource.iconsCloud,
        onPressed: () {},
      ),
      Gap.k16.width,
      ActionButton(
        icon: Resource.iconsInfo,
        onPressed: () {},
      ),
      Gap.k16.width,
      Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: ActionButton(
          icon: Resource.iconsBell,
          onPressed: () {},
        ),
      )
    ],
  );
}
