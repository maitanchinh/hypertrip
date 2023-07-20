import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:hypertrip/managers/firebase_messaging_manager.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/utils/base_page.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

part '../chat_detail/components/member_list.dart';
class ChatDetailPage extends StatefulWidget {
  static const routeName = '/chat-detail';

  final AssignGroupResponse assignGroupResponse;

  const ChatDetailPage({Key? key, required this.assignGroupResponse}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final PanelController _panelController = PanelController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isAccepting = widget.assignGroupResponse.status == 'Ongoing';

    return BlocProvider(
      create: (BuildContext context) => ChatDetailBloc(
        GetIt.I.get<FirestoreRepository>(),
        GetIt.I.get<TourRepo>(),
        GetIt.I.get<FoursquareRepo>(),
        GetIt.I.get<FirebaseMessagingManager>(),
        GetIt.I.get<UserRepo>(),
      )
        ..add(GetMembersTourGroup(widget.assignGroupResponse.id, UserRepo.profile?.id ?? ''))
        ..add(FetchMessageGroupChat(widget.assignGroupResponse.id))
        ..add(const RequestPermissionLocationEvent()),
      child: BaseWidget(
        unFocusWhenTouchOutsideInput: true,
        child: BlocBuilder<ChatDetailBloc, ChatDetailState>(
          builder: (context, state) => Scaffold(
            endDrawer: MemberList(
              members: state.members,
            ),
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              flexibleSpace: SafeArea(
                child: Container(
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Image.asset(
                          AppAssets.icons_icon_arrow_back_png,
                          color: Colors.black,
                          width: 16,
                          height: 16,
                        ),
                      ),
                      2.width,
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: Colors.white,
                        child: CachedNetworkImage(
                          imageUrl: widget.assignGroupResponse.trip?.tour?.thumbnailUrl ?? '',
                          width: 46,
                          height: 46,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: AppColors.grey2Color,
                              ),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: AppColors.grey2Color,
                              ),
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 37.5,
                            height: 37.5,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: AppColors.grey2Color,
                              ),
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                      12.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              widget.assignGroupResponse.groupName,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            6.width
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            extendBodyBehindAppBar: true,
            body: BlocBuilder<ChatDetailBloc, ChatDetailState>(
              builder: (context, state) {
                print("state.isCanDrag ${state.isCanDrag}");
                return SlidingUpPanel(
                  defaultPanelState: PanelState.CLOSED,
                  controller: _panelController,
                  minHeight: 0.0,
                  maxHeight: 500.0,
                  disableDraggableOnScrolling: !state.isCanDrag,
                  panelBuilder: () {
                    return ShareMap(
                      onSharePosition: (position) {
                        context.read<ChatDetailBloc>().add(
                              SendMessageGroupChat(
                                userId: UserRepo.profile?.id ?? '',
                                message:
                                    "http://maps.google.com/maps?q=${position.latitude},${position.longitude}&iwloc=A",
                                type: MessageType.custom,
                                groupId: widget.assignGroupResponse.id,
                                groupName: widget.assignGroupResponse.groupName,
                              ),
                            );

                        _panelController.close();
                      },
                    );
                  },
                  body: ChatList(
                    isAccepting: isAccepting,
                    tourGroupId: widget.assignGroupResponse.id,
                    onPressedMap: () {
                      context.read<ChatDetailBloc>().add(StatusMapEvent(state.isOpenMap));
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
