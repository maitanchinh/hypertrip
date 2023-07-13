import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hypertrip/domain/models/group/assign_group_response.dart';
import 'package:hypertrip/domain/repositories/firestore_repository.dart';
import 'package:hypertrip/domain/repositories/group_repo.dart';
import 'package:hypertrip/domain/repositories/tour_repo.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/features/public/chat/interactor/chat_bloc.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/base_page.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/app_bar.dart';
import 'package:hypertrip/widgets/text_form_field_title.dart';
import 'package:nb_utils/nb_utils.dart';

part '../chat/components/conversation_list.dart';
class ChatPageScreen extends StatelessWidget {
  const ChatPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChatBloc(GetIt.I.get<TourRepo>(),
          GetIt.I.get<GroupRepo>(), GetIt.I.get<FirestoreRepository>())
        ..add(FetchGroupChat(UserRepo.profile?.id ?? '', UserRepo.profile?.role ?? 'Traveler')),
      child: BasePage(
        unFocusWhenTouchOutsideInput: true,
        child: Scaffold(
          appBar: const MainAppBar(title: contentChat),
          body: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ChatBloc>().add(FetchGroupChat(
                      UserRepo.profile?.id ?? '', UserRepo.profile?.id ?? 'Traveler'));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormFieldTitle(
                      hintText: searchHint,
                      borderRadius: 20,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      widthPrefix: 50,
                      paddingBottom: 10,
                      onChanged: (value) => context.read<ChatBloc>().add(SearchGroupEvent(value)),
                    ),
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
                        return const Divider(height: 1, color: AppColors.whiteLightColor);
                      },
                    ),
                  ],
                ).paddingOnly(left: 16, top: 8, right: 16),
              );
            },
          ),
        ),
      ),
    );
  }
}
