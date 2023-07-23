part of '../chat_detail_page.dart';

class MemberList extends StatelessWidget {
  final List<ChatUser> members;
  const MemberList({Key? key, required this.members}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDetailBloc, ChatDetailState>(
      builder: (context, state) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16))),
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.only(left: 100),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                20.height,
                Align(
                  alignment: Alignment.topCenter,
                  child: PText(
                    'Members',
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: members
                        .map((member) => MemberItem(data: member))
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
