part of '../view.dart';

class Partner extends StatelessWidget {
  final LoadCurrentTourSuccessState state;

  const Partner({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SafeSpace(
      child: CardSection(
        title: label_partner,
        child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children:
                state.members.map((member) => _buildMember(member)).toList()),
      ),
    );
  }

  Widget _buildMember(Member member) {
    return Center(
      child: Column(
        children: [
          commonCachedNetworkImage(member.avatarUrl,
              height: 46, width: 46, radius: 46, fit: BoxFit.cover, type: 'avatar'),
          SizedBox(
            height: 30,
            width: 80,
            child: Text(
              '${member.firstName} ${member.lastName}',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textColor,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
