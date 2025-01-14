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
    return Container(
        width: context.width(),
        // padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          commonCachedNetworkImage(
                  widget.place.photos != null && widget.place.photos!.isNotEmpty
                      ? '${widget.place.photos![widget.photoIndex].prefix}100x100${widget.place.photos![widget.photoIndex].suffix}'
                      : Resource.imagesPlaceholder,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover)
              .cornerRadiusWithClipRRect(16),
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
                      PText(
                        widget.place.name!,
                        size: 16,
                      ),
                      8.height,
                      PText(
                        widget.place.categories!.isNotEmpty
                            ? widget.place.categories!.first.name.toString()
                            : '',
                        size: 16,
                      ),
                    ],
                  ).expand(),
                  SvgPicture.asset(
                    Resource.iconsShare,
                    width: 16,
                    color: AppColors.primaryColor,
                  )
                ],
              ).paddingOnly(left: 3),
              8.height,
              Row(
                children: [
                  Flexible(
                    child: PSmallText(
                      widget.place.distance! > 100
                          ? '${(widget.place.distance! / 1000).toStringAsFixed(2)} km away'
                          : 'Nearby',
                      size: 16,
                    ),
                  ),
                ],
              ),
              8.height,
              Row(
                children: [
                  widget.place.rating != null
                      ? SvgPicture.asset(
                          Resource.iconsStar,
                          width: 12,
                          color: Colors.amber,
                        )
                      : const SizedBox.shrink(),
                  6.width,
                  Expanded(
                    child: PSmallText(
                      widget.place.rating != null
                          ? widget.place.rating.toString()
                          : '',
                      size: 16,
                    ),
                  ),
                  PSmallText(
                    widget.place.hours?.openNow.toString() == 'true'
                        ? 'Opening'
                        : 'Closed',
                    color: widget.place.hours?.openNow.toString() == 'true'
                        ? Colors.green
                        : Colors.red,
                  )
                ],
              ),
              8.height,
              const Divider()
            ],
          ).expand(),
        ])).onTap(() {
      DetailsScreen(
        place: widget.place,
      ).launch(context);
    });
  }
}
