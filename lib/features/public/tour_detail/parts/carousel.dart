part of '../view.dart';

Widget _buildCarousel(LoadTourDetailSuccessState state) {
  //TODO: implement carousel
  const maxItem = 4;
  // var length = state.tour.carousel?.length ?? 0;
  const length = 7;

  const hasLastOverLay = length > maxItem;
  const moreItem = length - maxItem + 1;

  return GridView.builder(
    physics: const NeverScrollableScrollPhysics(),
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: maxItem,
      crossAxisSpacing: 16,
      childAspectRatio: 1,
    ),
    itemCount: length > maxItem ? maxItem : length,
    // itemCount: itemCount,
    itemBuilder: (context, index) {
      var isLast = index == maxItem - 1;

      return Stack(
        fit: StackFit.expand,
        children: [
          Container(
            child: commonCachedNetworkImage(
              state.tour.thumbnailUrl,
              fit: BoxFit.cover,
            ),
          ),

          /// last item overlay
          ...?((hasLastOverLay && isLast)
              ? [_buildOverlay('+$moreItem')]
              : null)
        ],
      );
    },
  );
}

Widget _buildOverlay(String text) {
  return Container(
    color: Colors.black.withOpacity(0.3),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white.withOpacity(0.9),
        ),
      ),
    ),
  );
}
