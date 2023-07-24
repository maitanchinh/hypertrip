
part of '../chat_detail_page.dart';

class MemberList extends StatelessWidget {
  final List<ChatUser> members;
  const MemberList({Key? key, required this.members}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create a temporary list to store the IDs that have appeared
    List<String> uniqueIds = [];

    // Create a new list to store unique members (no duplicate IDs)
    List<ChatUser> uniqueMembers = [];

    // Loop through each member in the original list
    for (var member in members) {
      // Check if the ID of the member has appeared before
      if (!uniqueIds.contains(member.id)) {
        // If the ID has not appeared, add it to the temporary list and add the member to the new list
        uniqueIds.add(member.id);
        uniqueMembers.add(member);
      }
    }

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
                    children: uniqueMembers.map((member) => MemberItem(data: member)).toList(),
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
