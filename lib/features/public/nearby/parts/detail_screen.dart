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
    final url =
        'http://maps.google.com/maps?q=${widget.place.geocodes!.main!.latitude},${widget.place.geocodes!.main!.longitude}&iwloc=A';
    final parsedUrl = Uri.parse(url);
    return Scaffold(
      backgroundColor: AppColors.bgLightColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.primaryLightColor,
                borderRadius: BorderRadius.circular(16)),
            child: AppButton(
              onTap: () {
                print(parsedUrl);
                launchUrl(parsedUrl);
              },
              color: AppColors.primaryColor,
              elevation: 0,
              child: Row(
                children: [
                  SvgPicture.asset(
                    Resource.iconsRoute,
                    color: AppColors.primaryColor,
                    width: 16,
                  ),
                  8.width,
                  const PSmallText(
                    'Get direction',
                    color: AppColors.primaryColor,
                    size: 16,
                  )
                ],
              ).paddingSymmetric(horizontal: 16),
            ),
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: ActionButton(
                    icon: Resource.iconsAngleLeft,
                    onPressed: () {
                      finish(context);
                    }),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: ActionButton(
                      icon: Resource.iconsShare,
                      onPressed: () {
                        finish(context);
                      }),
                ),
              ],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(47),
                    bottomRight: Radius.circular(47)),
              ),
              backgroundColor: AppColors.primaryColor,
              pinned: true,
              elevation: 2,
              expandedHeight: 240,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                titlePadding: const EdgeInsets.all(10),
                centerTitle: true,
                background: Stack(
                  children: [
                    // commonCachedNetworkImage(
                    //     widget.place.photos!.isNotEmpty
                    //         ? '${widget.place.photos![0].prefix}original${widget.place.photos![0].suffix}'
                    //         : Resource.placeholder,
                    //     height: 300,
                    //     width: context.width(),
                    //     fit: BoxFit.cover),
                    FadeInImage.assetNetwork(
                      placeholder: Resource.imagesPlaceholder,
                      image:
                          '${widget.place.photos![0].prefix}original${widget.place.photos![0].suffix}',
                      height: 300,
                      width: context.width(),
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        whiteColor.withOpacity(0.3),
                        AppColors.bgLightColor
                      ], begin: Alignment.center, end: Alignment.bottomCenter)),
                      width: context.width(),
                      height: 300,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PText(
                            '${widget.place.name}',
                            size: 30,
                          ),
                          8.height,
                          PSmallText(
                            widget.place.categories!.first.name.validate(),
                            color: AppColors.textColor,
                            size: 16,
                          ),
                        ],
                      ).expand(),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: DetailComponent(place: widget.place),
        ),
      ),
    );
  }
}
