import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatview/chatview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hypertrip/features/public/account/parts/share_location_map.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/widgets/image/image.dart';
import 'package:hypertrip/widgets/space/gap.dart';
import 'package:hypertrip/widgets/text/p_small_text.dart';
import 'package:nb_utils/nb_utils.dart';

class MemberItem extends StatelessWidget {
  final ChatUser data;
  const MemberItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Row(
        children: [
          Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 2, color: AppColors.textGreyColor)),
              child: commonCachedNetworkImage(data.profilePhoto,
                  type: 'avatar', radius: 100, fit: BoxFit.cover)),
          // CircleAvatar(
          //   radius: 23,
          //   backgroundColor: Colors.white,
          //   child: CachedNetworkImage(
          //     imageUrl: data.profilePhoto ?? '',
          //     width: 56,
          //     height: 56,
          //     imageBuilder: (context, imageProvider) => Container(
          //       width: 56,
          //       height: 56,
          //       decoration: BoxDecoration(
          //         border: Border.all(
          //           width: 2,
          //           color: AppColors.grey2Color,
          //         ),
          //         shape: BoxShape.circle,
          //         image: DecorationImage(
          //           image: imageProvider,
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //     ),
          //     placeholder: (context, url) => Container(
          //       width: 150,
          //       height: 150,
          //       decoration: BoxDecoration(
          //         border: Border.all(
          //           width: 2,
          //           color: AppColors.grey2Color,
          //         ),
          //         shape: BoxShape.circle,
          //         color: Colors.white,
          //       ),
          //       child: const Center(
          //         child: CircularProgressIndicator(),
          //       ),
          //     ),
          //     errorWidget: (context, url, error) => Container(
          //       width: 37.5,
          //       height: 37.5,
          //       decoration: BoxDecoration(
          //         border: Border.all(
          //           width: 2,
          //           color: AppColors.grey2Color,
          //         ),
          //         shape: BoxShape.circle,
          //         color: Colors.white,
          //       ),
          //       child: const Center(
          //         child: Icon(
          //           Icons.error,
          //           color: Colors.red,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Gap.k16.width,
          Expanded(
            child: PSmallText(
              data.name,
              color: AppColors.textColor,
            ),
          ),
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('location').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  bool profileExists =
                      snapshot.data!.docs.any((doc) => doc.id == data.id);
                  if (profileExists) {
                    return SvgPicture.asset(
                      AppAssets.icons_location_arrow_solid_svg,
                      width: 20,
                      color: AppColors.primaryColor,
                    ).onTap((){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShareLocationMap(userId: data.id)));
                    });
                  }
                  return SizedBox.shrink();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return CircularProgressIndicator();
                }
              })
        ],
      ),
    );
  }
}
