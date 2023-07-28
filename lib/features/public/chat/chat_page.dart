import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hypertrip/domain/models/chat/firestore_message.dart';
import 'package:hypertrip/domain/models/group/assign_group_response.dart';
import 'package:hypertrip/domain/repositories/firestore_repository.dart';
import 'package:hypertrip/domain/repositories/group_repo.dart';
import 'package:hypertrip/domain/repositories/tour_repo.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/features/public/chat/interactor/chat_bloc.dart';
import 'package:hypertrip/features/public/chat_detail/chat_detail_page.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/base_page.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/app_bar.dart';
import 'package:hypertrip/widgets/safe_space.dart';
import 'package:hypertrip/widgets/space/gap.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../generated/resource.dart';
import '../../../widgets/text/p_small_text.dart';
import '../../../widgets/text/p_text.dart';

part '../chat/components/conversation_list.dart';

class ChatPageScreen extends StatelessWidget {
  const ChatPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChatBloc(GetIt.I.get<TourRepo>(),
          GetIt.I.get<GroupRepo>(), GetIt.I.get<FirestoreRepository>())
        ..add(FetchGroupChat(
            UserRepo.profile?.id ?? '', UserRepo.profile?.role ?? 'Traveler')),
      child: BaseWidget(
        unFocusWhenTouchOutsideInput: true,
        child: SafeArea(
          child: Scaffold(
            // appBar: const MainAppBar(title: contentChat),
            body: SafeSpace(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<ChatBloc>().add(FetchGroupChat(
                          UserRepo.profile?.id ?? '',
                          UserRepo.profile?.id ?? 'Traveler'));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(16)),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: searchHint,
                                prefixIcon: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: Transform.scale(
                                    scale: 0.5,
                                    child: SvgPicture.asset(
                                      Resource.iconsSearch,
                                      // width: 16,
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                ),
                                border: InputBorder.none),
                            onChanged: (value) => context
                                .read<ChatBloc>()
                                .add(SearchGroupEvent(value)),
                          ),
                        ),
                        // TextFormFieldTitle(
                        //   hintText: searchHint,
                        //   borderRadius: 16,
                        //   prefixIcon: SizedBox(
                        //     width: 16,
                        //     height: 16,
                        //     child: Transform.scale(
                        //       scale: 0.5,
                        //       child: SvgPicture.asset(
                        //         Resource.iconsSearch,
                        //         // width: 16,
                        //         color: AppColors.secondaryColor,
                        //       ),
                        //     ),
                        //   ),
                        //   widthPrefix: 50,
                        //   paddingBottom: 10,
                        //   onChanged: (value) =>
                        //       context.read<ChatBloc>().add(SearchGroupEvent(value)),
                        // ),
                        Gap.kSection.height,
                        ListView.separated(
                          itemCount: state.groupChat.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 0),
                          itemBuilder: (context, index) {
                            return ConversationList(
                              data: state.groupChat[index],
                              userID: UserRepo.profile?.id ?? '',
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Gap.k8.height,
                                const Divider(
                                    height: 1,
                                    color: AppColors.whiteLightColor),
                                Gap.k8.height,
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
