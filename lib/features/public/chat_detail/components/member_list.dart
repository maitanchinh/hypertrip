
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
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.only(left: 100),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                20.height,
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Danh sách thành viên",
                    style: boldTextStyle(size: 24),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: members.map((member) => MemberItem(data: member)).toList(),
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
