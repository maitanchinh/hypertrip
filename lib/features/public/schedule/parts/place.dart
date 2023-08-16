part of '../view.dart';

class PlaceItem extends StatefulWidget {
  final NearbyResults place;
  final int photoIndex;
  PlaceItem({super.key, required this.place, required this.photoIndex});

  @override
  State<PlaceItem> createState() => _PlaceItemState();
}

class _PlaceItemState extends State<PlaceItem> {
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
                      : AppAssets.placeholder_png,
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
                  InkWell(
                    onTap: () => _sendMessageGroupChat(context),
                    child: SvgPicture.asset(
                      AppAssets.icons_share_svg,
                      width: 16,
                      color: AppColors.primaryColor,
                    ),
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
                          AppAssets.icons_star_svg,
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
      PlaceDetailsScreen(
        place: widget.place,
      ).launch(context);
    });
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
}
