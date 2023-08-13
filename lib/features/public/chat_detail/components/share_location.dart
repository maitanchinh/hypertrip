import 'package:chatview/chatview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/widgets/button/action_button.dart';
import 'package:hypertrip/widgets/space/gap.dart';
import 'package:hypertrip/widgets/text/p_small_text.dart';
import 'package:hypertrip/widgets/text/p_text.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../account/parts/share_location_map.dart';

class ShareLocation extends StatelessWidget {
  final Message message;
  const ShareLocation({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String urlParse = '';
    String textContent = '';
    int httpIndex = message.message.indexOf("http");
    if (httpIndex != -1) {
      textContent = message.message.substring(0, httpIndex);
      urlParse = message.message.substring(httpIndex);
    } else {
      urlParse = message.message; // Phần trước "http"
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ActionButton(
                  icon: AppAssets.icons_location_arrow_solid_svg,
                  bgColor: AppColors.primaryColor,
                  onPressed: () {}),
              Gap.k16.width,
              SizedBox(
                  width: context.width() * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PText('Live location'),
                      Gap.k8.height,
                      PSmallText(textContent)
                    ],
                  )),
            ],
          ),
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('location').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return MaterialButton(
                  elevation: 0,
                  height: 40,
                  minWidth: context.width(),
                  color: AppColors.primaryLightColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    side: BorderSide.none,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ShareLocationMap(userId: message.id)));
                  },
                  child: PText('View location',),
                );
              })
        ],
      ),
    );
  }
}
