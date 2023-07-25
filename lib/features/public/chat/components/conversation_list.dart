part of '../chat_page.dart';

class ConversationList extends StatelessWidget {
  final AssignGroupResponse data;
  final String userID;

  const ConversationList({super.key, required this.data, required this.userID});
  @override
  Widget build(BuildContext context) {
    bool isAccepting = data.trip?.status == 'Ongoing';
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, ChatDetailPage.routeName,
          arguments: data),
      child: StreamBuilder<FirestoreMessage>(
        stream: GetIt.I.get<FirestoreRepository>().fetchLastedMessage(data.id),
        builder: (context, snapshot) {
          final lastMsg = snapshot.data;
          return Opacity(
            opacity: isAccepting ? 1 : 0.5,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: CachedNetworkImage(
                          imageUrl: data.trip?.tour?.thumbnailUrl ?? '',
                          width: 56,
                          height: 56,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 56,
                            height: 56,
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
                      16.width,
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              PText(
                                data.groupName,
                                size: 16,
                              ),
                              Gap.k8.height,
                              if (lastMsg != null)
                                PSmallText(
                                  lastMsg.content,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isAccepting)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: DecoratedBox(
                        decoration: const BoxDecoration(color: redColor),
                        child: const PSmallText(
                          close,
                          color: white,
                        ).paddingSymmetric(horizontal: 8, vertical: 4)),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
