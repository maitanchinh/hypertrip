part of '../view.dart';

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final LoadCurrentTourSuccessState state;

  const CustomSliverAppBarDelegate({
    required this.state,
    required this.expandedHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    const size = 60;
    final top = expandedHeight - shrinkOffset - size / 2;

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        buildBackground(shrinkOffset),
        Positioned(
          top: top,
          left: 0,
          right: 0,
          child: buildFloating(context, shrinkOffset),
        ),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildBackground(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16)),
          child: FadeInImage.assetNetwork(
            placeholder: Resource.imagesPlaceholder,
            image: state.group.trip?.tour!.thumbnailUrl as String,
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget buildFloating(BuildContext context, double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: SafeSpace(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: defaultButtonRoundedShape,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                      ),
                      icon: SvgPicture.asset(
                        Resource.iconsPlane,
                        width: 16,
                        color: white,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, TourDetailPage.routeName,
                            arguments: {'tourId': state.group.trip?.tour?.id});
                      },
                      label: PText(
                        state.group.trip?.tour?.title ?? "",
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Gap.k8.width,
                  SizedBox(
                    width: 150,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: defaultButtonRoundedShape,
                        backgroundColor: AppColors.yellowColor,
                      ),
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        Resource.iconsClipboardUser,
                        width: 16,
                        color: white,
                      ),
                      label: const PText(
                        'Attendance',
                        overflow: TextOverflow.visible,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
