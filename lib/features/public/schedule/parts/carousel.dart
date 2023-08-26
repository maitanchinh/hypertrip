part of '../view.dart';

Widget _buildCarousel(NearbyResults place) {
//TODO: implement carousel
  const maxItem = 4;
  var length = place.photos!.length;
  // const length = 7;

  final hasLastOverLay = length > maxItem;
  final moreItem = length - maxItem + 1;

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
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlacePhotoScreen(
                            photos: place.photos,
                            currentPhotoIndex: index,
                          )));
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: commonCachedNetworkImage('${place.photos![index].prefix}100x100${place.photos![index].suffix}', fit: BoxFit.cover)
                // FadeInImage.assetNetwork(
                //   placeholder: AppAssets.placeholder_png,
                //   image:
                //       '${place.photos![index].prefix}100x100${place.photos![index].suffix}',
                //   fit: BoxFit.cover,
                // )
                ),
          ),

          /// last item overlay
          ...?((hasLastOverLay && isLast)
              ? [IgnorePointer(child: _buildOverlay('+$moreItem'))]
              : null)
        ],
      );
    },
  );
}

Widget _buildOverlay(String text) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Container(
      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: black.withOpacity(opacity)),
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
    ),
  );
}
