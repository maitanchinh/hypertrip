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
        child: commonCachedNetworkImage(
          state.group.trip?.tour?.thumbnailUrl,
          fit: BoxFit.cover,
        ),
      );

  Widget buildFloating(BuildContext context, double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: SafeSpace(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              shape: defaultButtonRoundedShape,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                            ),
                            icon: const Icon(Icons.airplanemode_active),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, TourDetailPage.routeName,
                                  arguments: {
                                    'tourId': state.group.trip?.tour?.id
                                  });
                            },
                            label: PText(
                              state.group.trip?.tour?.title ?? "",
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Gap.k8.height,
                        SizedBox(
                          width: 130,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: defaultButtonRoundedShape,
                              backgroundColor: AppColors.yellowColor,
                            ),
                            onPressed: () {},
                            child: const PText(
                              'Attendance',
                              overflow: TextOverflow.visible,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
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
