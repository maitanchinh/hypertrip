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
            padding: EdgeInsets.zero,
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        commonCachedNetworkImage(member.avatarUrl,
            height: 46,
            width: 46,
            radius: 46,
            fit: BoxFit.cover,
            type: 'avatar'),
        Gap.k8.height,
        PSmallText(
          '${member.firstName} ${member.lastName}',
          color: AppColors.textColor,
        ),
      ],
    );
  }
}
