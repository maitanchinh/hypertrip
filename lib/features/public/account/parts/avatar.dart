import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_assets.dart';

class AvatarProfile extends StatelessWidget {
  final String url;
  const AvatarProfile({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: FadeInImage.assetNetwork(
                      placeholder: AppAssets.avatar_placeholder_png, image: url),
                )),
          ),
          Positioned(
            right: 0,
            left: 0,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.4),
                  width: 1,
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            left: 8,
            bottom: 8,
            child: Container(
              width: 182,
              height: 182,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.6),
                  width: 2,
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            left: 16,
            bottom: 16,
            child: Container(
              width: 166,
              height: 166,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.8),
                  width: 3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
