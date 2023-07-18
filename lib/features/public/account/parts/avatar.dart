import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';

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
          Positioned(
            top: 24,
            right: 24,
            left: 24,
            bottom: 24,
            child: CircleAvatar(
              radius: 75,
              backgroundColor: Colors.white,
              child: CachedNetworkImage(
                imageUrl: url,
                width: 150,
                height: 150,
                imageBuilder: (context, imageProvider) => Container(
                  width: 150,
                  height: 150,
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
                  color: AppColors.secondaryColor.withOpacity(0.4),
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
                  color: AppColors.secondaryColor.withOpacity(0.6),
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
                  color: AppColors.secondaryColor.withOpacity(0.8),
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
