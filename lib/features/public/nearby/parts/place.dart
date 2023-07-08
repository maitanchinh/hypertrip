part of '../view.dart';

class Place extends StatefulWidget {
  final NearbyResults place;
  final int photoIndex;
  Place({super.key, required this.place, required this.photoIndex});

  @override
  State<Place> createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PlacePhotoCubit(widget.place.fsqId),
      child: Builder(
          builder: (context) =>
              _buildPlaceList(context, widget.photoIndex, widget.place)),
    );
  }
}

Widget _buildPlaceList(
    BuildContext context, int photoIndex, NearbyResults place) {
  return Container(
      width: context.width(),
      decoration:
          boxDecorationRoundedWithShadow(8, backgroundColor: context.cardColor),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        BlocBuilder<PlacePhotoCubit, PlacePhotoState>(
          builder: (context, state) {
            if (state is LoadPlacePhotoSuccessState) {
              return commonCachedNetworkImage(
                  '${state.photos[photoIndex].prefix}100x100${state.photos[photoIndex].suffix}',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover);
            }
            if (state is NoResultPlacePhotoState) {
              return commonCachedNetworkImage(Resource.imagesPlaceholder,
                  height: 100, width: 100, fit: BoxFit.cover);
            }
            return commonCachedNetworkImage(Resource.imagesPlaceholder,
                height: 100, width: 100, fit: BoxFit.cover);
          },
        ).cornerRadiusWithClipRRect(8),
        16.width,
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PText(place.name!),
                    8.height,
                    PSmallText(place.categories!.isNotEmpty
                        ? place.categories!.first.name.toString()
                        : ''),
                  ],
                ).expand(),
              ],
            ).paddingOnly(left: 3),
            8.height,
            Row(
              children: [
                SvgPicture.asset(
                  Resource.iconsLocationDot,
                  width: 16,
                  color: AppColors.primaryColor,
                ),
                6.width,
                Flexible(
                  child: PSmallText(
                    place.location!.address != null
                        ? place.location!.formattedAddress.toString()
                        : 'The address has not been added',
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: PSmallText(
                    place.distance! > 100
                        ? '${(place.distance! / 1000).toStringAsFixed(2)} km away'
                        : 'Nearby',
                  ),
                ),
              ],
            )
          ],
        ).expand()
      ])).onTap(() {
    DetailsScreen(
      place: place,
    ).launch(context);
  });
}
