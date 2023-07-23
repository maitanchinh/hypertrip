part of '../view.dart';

class DetailComponent extends StatefulWidget {
  final NearbyResults place;

  DetailComponent({required this.place});

  @override
  State<DetailComponent> createState() => _DetailComponentState();
}

class _DetailComponentState extends State<DetailComponent> {
  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.8);
  }

  late final PageController _controller;
  @override
  Widget build(BuildContext context) {
    return SafeSpace(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.place.rating != null)
                      Row(
                        children: [
                          SvgPicture.asset(
                            Resource.iconsStar,
                            color: Colors.amber,
                            width: 16,
                          ),
                          16.width,
                          PSmallText(
                            widget.place.rating.toString(),
                            color: AppColors.textColor,
                          )
                        ],
                      )
                    else
                      const SizedBox.shrink(),
                    16.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          Resource.iconsLocationDot,
                          height: 16,
                          color: AppColors.primaryColor,
                        ),
                        16.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PSmallText(
                              widget.place.location!.address != null
                                  ? '${widget.place.location!.address}'
                                  : '',
                              color: AppColors.textColor,
                            ),
                            8.height,
                            PSmallText(
                              widget.place.distance! > 100
                                  ? '${(widget.place.distance! / 1000).toStringAsFixed(2)} km away'
                                  : 'Nearby',
                              color: AppColors.textColor,
                            ),
                          ],
                        ).expand(),
                        16.width,
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      widget.place.tel != null
                          ?
                          // Container(
                          //     padding: const EdgeInsets.all(16),
                          //     decoration: const BoxDecoration(
                          //         color: AppColors.primaryLightColor,
                          //         shape: BoxShape.circle),
                          //     child: SvgPicture.asset(
                          //       Resource.iconsPhone,
                          //       width: 16,
                          //       color: AppColors.primaryColor,
                          //     ),
                          //   ).onTap(() {
                          //     launch(
                          //         'tel:${widget.place.tel!.replaceAll(' ', '')}');
                          //   })
                          ActionButton(
                              icon: Resource.iconsPhone,
                              bgColor: AppColors.primaryLightColor,
                              iconColor: AppColors.primaryColor,
                              onPressed: () {
                                launch(
                                    'tel:${widget.place.tel!.replaceAll(' ', '')}');
                              })
                          : const SizedBox.shrink(),
                      16.width,
                      widget.place.website != null
                          ? ActionButton(
                              icon: Resource.iconsWeb,
                              bgColor: AppColors.primaryLightColor,
                              iconColor: AppColors.primaryColor,
                              onPressed: () {
                                launchUrl(
                                    Uri.parse(widget.place.website.toString()));
                              })
                          : const SizedBox.shrink(),
                      // 8.width,
                      // PSmallText(
                      //   widget.place.tel.toString(),
                      //   color: AppColors.textColor,
                      //   size: 16,
                      // )
                    ],
                  )
                ],
              )
            ],
          ),
          32.height,
          widget.place.photos!.isNotEmpty
              ? const PText(
                  'Gallery',
                  size: 24,
                )
              : const SizedBox.shrink(),
          16.height,
          // HorizontalList(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   wrapAlignment: WrapAlignment.spaceEvenly,
          //   itemCount: widget.place.photos!.length,
          //   itemBuilder: (_, int index) => Stack(
          //     alignment: Alignment.center,
          //     children: [
          //       ClipRRect(
          //         borderRadius: BorderRadius.circular(16),
          //         child: FadeInImage.assetNetwork(
          //           placeholder: Resource.imagesPlaceholder,
          //           image:
          //               '${widget.place.photos![index].prefix}100x100${widget.place.photos![index].suffix}',
          //           height: 70,
          //           width: 70,
          //           fit: BoxFit.cover,
          //         ),
          //       ).onTap(() {
          //         Navigator.push(context, MaterialPageRoute(builder: (context) {
          //           return PlacePhoto(
          //               photos: widget.place.photos, currentPhotoIndex: index);
          //         }));
          //       })
          //     ],
          //   ),
          // ),
          _buildCarousel(widget.place),
          32.height,
          widget.place.tips!.isNotEmpty
              ? const PText(
                  'Tips',
                  size: 24,
                )
              : const SizedBox.shrink(),
          16.height,
          SizedBox(
            height: 150,
            width: context.width(),
            child: PageView.builder(
                controller: _controller,
                itemCount: widget.place.tips!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: widget.place.tips!.length > 1
                        ? const EdgeInsets.only(right: 8)
                        : const EdgeInsets.only(right: 0),
                    child: Stack(alignment: Alignment.center, children: [
                      Container(
                        width: context.width(),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PSmallText(
                              DateFormat('dd/MM/yyyy').format(DateTime.parse(
                                  widget.place.tips![index].createdAt
                                      .toString())),
                            ),
                            8.height,
                            PSmallText(
                              '${widget.place.tips![index].text}',
                              color: AppColors.textColor,
                            ),
                          ],
                        ),
                      ),
                    ]),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
