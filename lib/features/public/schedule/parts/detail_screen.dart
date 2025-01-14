part of '../view.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final NearbyResults place;

  PlaceDetailsScreen({required this.place});

  @override
  _PlaceDetailsScreenState createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
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

  FutureOr<void> _sendMessageGroupChat(BuildContext context) async {
    var rootCubit = BlocProvider.of<RootCubit>(context);
    var rootState = rootCubit.state as RootSuccessState;

    final firestoreRepository = GetIt.I.get<FirestoreRepository>();
    // final firebaseMessagingManager = GetIt.I.get<FirebaseMessagingManager>();

    final groupId = rootState.group?.id ?? '';
    final userId = UserRepo.profile?.id ?? '';

    if (widget.place.geocodes == null) return toast("Not found location");

    String message =
        "http://maps.google.com/maps?q=${widget.place.geocodes?.main?.latitude ?? 0.0},${widget.place.geocodes?.main?.longitude}&iwloc=A";

    final result = await firestoreRepository.saveMessage(
        userId, MessageType.text, message, DateTime.now(), groupId);

    if (result == null) {
      toast(currentNotSendMessage);
    } else {
      toast(sendSuccess);
    }
    // TODO: send noti for member group chat

    // String content = UserRepo.profile?.displayName ?? '';
    // content += ' đã chia sẻ vị trí hiện tại';
    // firebaseMessagingManager.sendFCMNotifications(state.deviceTokens, event.groupName, content);
    //
    // if (result == null) toast(msg.currentNotSendMessage);
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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.primaryLightColor,
                borderRadius: BorderRadius.circular(16)),
            child: AppButton(
              onTap: () {
                launchUrl(parsedUrl);
              },
              color: AppColors.primaryLightColor,
              elevation: 0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppAssets.icons_route_svg,
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
                    icon: AppAssets.icons_angle_left_svg,
                    onPressed: () {
                      finish(context);
                    }),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: ActionButton(
                      icon: AppAssets.icons_share_svg,
                      onPressed: () {
                        _sendMessageGroupChat(context);
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
                    commonCachedNetworkImage(
                        widget.place.photos!.isNotEmpty
                            ? '${widget.place.photos![0].prefix}original${widget.place.photos![0].suffix}'
                            : AppAssets.placeholder_png,
                        height: 300,
                        width: context.width(),
                        fit: BoxFit.cover),
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: PlaceDetailComponent(place: widget.place),
        ),
      ),
    );
  }
}
