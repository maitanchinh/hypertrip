part of '../view.dart';

class DetailComponent extends StatefulWidget {
  final NearbyResults place;

  DetailComponent({required this.place});

  @override
  State<DetailComponent> createState() => _DetailComponentState();
}

class _DetailComponentState extends State<DetailComponent> {
  late Future<List<Tip>> tips;
  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.8);
  }

  late final PageController _controller;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                PlacePhotoCubit(widget.place.fsqId)),
        BlocProvider(
            create: (BuildContext context) => PlaceTipCubit(widget.place.fsqId))
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // rfCommonCachedNetworkImage(rf_user,
                  //         width: 60, height: 60, fit: BoxFit.cover)
                  //     .cornerRadiusWithClipRRect(30),
                  // 16.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PText('${widget.place.name}'),
                    ],
                  ).expand(),
                ],
              ),
              16.height,
              PSmallText(
                widget.place.categories!.first.name.validate(),
                color: AppColors.textColor,
                size: 16,
              ),
              24.height,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    Resource.iconsLocationDot,
                    width: 16,
                    color: AppColors.primaryColor,
                  ).paddingOnly(top: 2),
                  16.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PText(
                        widget.place.distance! > 100
                            ? '${(widget.place.distance! / 1000).toStringAsFixed(2)} km away'
                            : 'Nearby',
                      ),
                      8.height,
                      PSmallText(
                        widget.place.location!.address != null
                            ? '${widget.place.location!.address}'
                            : '',
                        color: AppColors.textColor,
                        size: 16,
                      ),
                    ],
                  ).expand(),
                  16.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppButton(
                        // onTap: () {
                        //   showDialog(
                        //       context: context,
                        //       builder: (BuildContext context) => (MapDialog(
                        //             lat: widget.place.geocodes!.main!.latitude,
                        //             lng: widget.place.geocodes!.main!.longitude,
                        //             placeNearby: widget.place,
                        //           )));
                        //   setState(() {});
                        // },
                        color: AppColors.primaryColor,
                        width: 5,
                        height: 5,
                        elevation: 0,
                        child: SvgPicture.asset(
                          Resource.iconsMap,
                          color: AppColors.primaryColor,
                          width: 32,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ).paddingAll(24),
          BlocBuilder<PlacePhotoCubit, PlacePhotoState>(
            builder: (context, state) {
              if (state is LoadPlacePhotoSuccessState) {
                return HorizontalList(
                  padding: const EdgeInsets.only(right: 24, left: 24),
                  wrapAlignment: WrapAlignment.spaceEvenly,
                  itemCount: state.photos.length,
                  itemBuilder: (_, int index) => Stack(
                    alignment: Alignment.center,
                    children: [
                      commonCachedNetworkImage(
                          '${state.photos[index].prefix}100x100${state.photos[index].suffix}',
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const PText('Tips').paddingOnly(left: 24, top: 24, bottom: 8),
          8.height,
          BlocBuilder<PlaceTipCubit, PlaceTipState>(builder: (context, state) {
            if (state is NoResultPlaceTipState) {
              return SizedBox(
                height: context.height() * 0.5,
                child: const SizedBox.shrink(),
              );
            }
            if (state is LoadPlaceTipSuccessState) {
              return SizedBox(
                height: 150,
                width: context.width(),
                child: PageView.builder(
                    controller: _controller,
                    itemCount: state.tips.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Stack(alignment: Alignment.center, children: [
                          Container(
                            width: context.width(),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(DateFormat('dd/MM/yyyy').format(
                                    DateTime.parse(state.tips[index].createdAt
                                        .toString()))),
                                8.height,
                                Text('${state.tips[index].text}',
                                    style: primaryTextStyle()),
                              ],
                            ),
                          ),
                        ]),
                      );
                    }),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
