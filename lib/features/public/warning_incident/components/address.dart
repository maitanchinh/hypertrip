import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:nb_utils/nb_utils.dart';

class Address extends StatelessWidget {
  final String address;
  const Address({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AppAssets.icons_location_dot_svg,
          width: 12,
          height: 16,
          color: Colors.white,
        ),
        8.width,
        Text(address,
            style: AppStyle.fontOpenSanRegular.copyWith(fontSize: 14, color: Colors.white)),
      ],
    );
  }
}
