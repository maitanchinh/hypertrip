import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
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
          CircleAvatar(
            radius: 23,
            backgroundColor: Colors.white,
            child: CachedNetworkImage(
              imageUrl: data.profilePhoto ?? '',
              width: 56,
              height: 56,
              imageBuilder: (context, imageProvider) => Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: AppColors.grey2Color,
                  ),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: AppColors.grey2Color,
                  ),
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 37.5,
                height: 37.5,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: AppColors.grey2Color,
                  ),
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
          16.width,
          Text(
            data.name,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
