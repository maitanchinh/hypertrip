part of '../view.dart';

class DetailsScreen extends StatefulWidget {
  final NearbyResults place;

  DetailsScreen({required this.place});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PlacePhotoCubit(widget.place.fsqId),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: IconButton(
                  icon:
                      SvgPicture.asset(Resource.iconsAngleLeft, color: white, width: 16),
                  onPressed: () {
                    finish(context);
                  },
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                ),
                backgroundColor: AppColors.primaryColor,
                pinned: true,
                elevation: 2,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  titlePadding: const EdgeInsets.all(10),
                  centerTitle: true,
                  background: Stack(
                    children: [
                      BlocBuilder<PlacePhotoCubit, PlacePhotoState>(
                        builder: (context, state) {
                          if (state is LoadPlacePhotoSuccessState) {
                            return commonCachedNetworkImage(
                                '${state.photos[0].prefix}original${state.photos[0].suffix}',
                                height: 350,
                                width: context.width(),
                                fit: BoxFit.cover);
                          }
                          if (state is NoResultPlacePhotoState) {
                            return commonCachedNetworkImage(
                                Resource.imagesPlaceholder,
                                height: 350,
                                width: context.width(),
                                fit: BoxFit.cover);
                          }
                          return commonCachedNetworkImage(Resource.imagesPlaceholder,
                              height: 350,
                              width: context.width(),
                              fit: BoxFit.cover);
                        },
                      ),
                      // commonCachedNetworkImage(
                      //   widget.photos.isNotEmpty
                      //       ? '${widget.photos[0].prefix}original${widget.photos[0].suffix}'
                      //       : '',
                      //   fit: BoxFit.cover,
                      //   width: context.width(),
                      //   height: 350,
                      // ),
                      // Container(
                      //   padding:
                      //       EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       PText(
                      //         widget.place.categories!.first.name.validate(),
                      //         color: AppColors.textColor,
                      //       ),
                      //       8.height,
                      //       // Row(
                      //       //   children: [
                      //       //     Text("${widget.hotelData!.price.validate()} ",
                      //       //         style: boldTextStyle(color: white)),
                      //       //     Text(widget.hotelData!.rentDuration.validate(),
                      //       //         style: secondaryTextStyle(color: white)),
                      //       //   ],
                      //       // ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                DetailComponent(place: widget.place),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
