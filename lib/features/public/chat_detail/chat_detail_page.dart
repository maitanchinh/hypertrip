import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hypertrip/domain/models/group/assign_group_response.dart';
import 'package:hypertrip/domain/repositories/firestore_repository.dart';
import 'package:hypertrip/domain/repositories/foursquare_repo.dart';
import 'package:hypertrip/domain/repositories/tour_repo.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/features/public/chat_detail/components/chat_list.dart';
import 'package:hypertrip/features/public/chat_detail/components/member_item.dart';
import 'package:hypertrip/features/public/chat_detail/components/share_map.dart';
import 'package:hypertrip/features/public/chat_detail/interactor/chat_detail_bloc.dart';
import 'package:hypertrip/generated/resource.dart';
import 'package:hypertrip/managers/firebase_messaging_manager.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/utils/base_page.dart';
import 'package:hypertrip/widgets/button/action_button.dart';
import 'package:hypertrip/widgets/image/image.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../../widgets/text/p_text.dart';

part '../chat_detail/components/member_list.dart';

class ChatDetailPage extends StatefulWidget {
  static const routeName = '/chat-detail';

  final AssignGroupResponse assignGroupResponse;

  const ChatDetailPage({Key? key, required this.assignGroupResponse})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final PanelController _panelController = PanelController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isAccepting = widget.assignGroupResponse.status == 'Ongoing' ||
        widget.assignGroupResponse.status == 'Prepare';

    return BlocProvider(
      create: (BuildContext context) => ChatDetailBloc(
        GetIt.I.get<FirestoreRepository>(),
        GetIt.I.get<TourRepo>(),
        GetIt.I.get<FoursquareRepo>(),
        GetIt.I.get<FirebaseMessagingManager>(),
        GetIt.I.get<UserRepo>(),
      )
        ..add(GetMembersTourGroup(
            widget.assignGroupResponse.id, UserRepo.profile?.id ?? ''))
        ..add(FetchMessageGroupChat(widget.assignGroupResponse.id))
        ..add(const RequestPermissionLocationEvent()),
      child: BaseWidget(
        unFocusWhenTouchOutsideInput: true,
        child: BlocBuilder<ChatDetailBloc, ChatDetailState>(
          builder: (context, state) => Scaffold(
            key: _scaffoldKey,
            endDrawer: MemberList(
              members: state.members,
            ),
            appBar: BlurredAppBar(
              assignGroupResponse: widget.assignGroupResponse,
              scaffoldKey: _scaffoldKey,
            ),
            extendBodyBehindAppBar: true,
            body: BlocBuilder<ChatDetailBloc, ChatDetailState>(
              builder: (context, state) {
                return SlidingUpPanel(
                  defaultPanelState: PanelState.CLOSED,
                  controller: _panelController,
                  minHeight: 0.0,
                  maxHeight: 500.0,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  disableDraggableOnScrolling: !state.isCanDrag,
                  panelBuilder: () {
                    return ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                      child: ShareMap(
                        onSharePosition: (position) {
                          context.read<ChatDetailBloc>().add(
                                SendMessageGroupChat(
                                  userId: UserRepo.profile?.id ?? '',
                                  message:
                                      "http://maps.google.com/maps?q=${position.latitude},${position.longitude}&iwloc=A",
                                  type: MessageType.custom,
                                  groupId: widget.assignGroupResponse.id,
                                  groupName:
                                      widget.assignGroupResponse.groupName,
                                ),
                              );

                          _panelController.close();
                        },
                      ),
                    );
                  },
                  body: ChatList(
                    isAccepting: isAccepting,
                    tourGroupId: widget.assignGroupResponse.id,
                    onPressedMap: () {
                      context
                          .read<ChatDetailBloc>()
                          .add(StatusMapEvent(state.isOpenMap));
                      _panelController.open();
                    },
                    groupName: widget.assignGroupResponse.groupName,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class BlurredAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AssignGroupResponse assignGroupResponse;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const BlurredAppBar(
      {super.key,
      required this.assignGroupResponse,
      required this.scaffoldKey});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ActionButton(
                  icon: AppAssets.icons_angle_left_svg,
                  iconColor: AppColors.textColor,
                  bgColor: transparentColor,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                    border:
                        Border.all(width: 2, color: AppColors.textGreyColor)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(23),
                  child: commonCachedNetworkImage(
                      assignGroupResponse.trip!.tour!.thumbnailUrl,
                      fit: BoxFit.cover),
                ),
              ),
              // CircleAvatar(
              //   radius: 23,
              //   backgroundColor: Colors.white,
              //   child: CachedNetworkImage(
              //     imageUrl: assignGroupResponse.trip?.tour?.thumbnailUrl ?? '',
              //     width: 46,
              //     height: 46,
              //     imageBuilder: (context, imageProvider) => Container(
              //       width: 46,
              //       height: 46,
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //           width: 2,
              //           color: AppColors.grey2Color,
              //         ),
              //         shape: BoxShape.circle,
              //         image: DecorationImage(
              //           image: imageProvider,
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ),
              //     placeholder: (context, url) => Container(
              //       width: 150,
              //       height: 150,
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //           width: 2,
              //           color: AppColors.grey2Color,
              //         ),
              //         shape: BoxShape.circle,
              //         color: Colors.white,
              //       ),
              //       child: const Center(
              //         child: CircularProgressIndicator(),
              //       ),
              //     ),
              //     errorWidget: (context, url, error) => Container(
              //       width: 37.5,
              //       height: 37.5,
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //           width: 2,
              //           color: AppColors.grey2Color,
              //         ),
              //         shape: BoxShape.circle,
              //         color: Colors.white,
              //       ),
              //       child: const Center(
              //         child: Icon(
              //           Icons.error,
              //           color: Colors.red,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    PText(
                      assignGroupResponse.groupName,
                    ),
                    6.width
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  scaffoldKey.currentState?.openEndDrawer();
                },
                icon: Transform.scale(
                  child: SvgPicture.asset(
                    Resource.iconsUsers,
                    color: AppColors.primaryColor,
                  ),
                  scale: 0.7,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
