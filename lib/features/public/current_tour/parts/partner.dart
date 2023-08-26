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
        UserRole.Traveler.compareWithString(member.role)
            ? commonCachedNetworkImage(member.avatarUrl,
                height: 46,
                width: 46,
                radius: 46,
                fit: BoxFit.cover,
                type: 'avatar')
            : Container(
                decoration: BoxDecoration(border: Border.all(width: 2, color: AppColors.greenColor), borderRadius: BorderRadius.circular(100)),
                child: commonCachedNetworkImage(member.avatarUrl,
                    height: 46,
                    width: 46,
                    radius: 46,
                    fit: BoxFit.cover,
                    type: 'avatar'),
              ),
        Gap.k8.height,
        PText(
          '${member.firstName} ${member.lastName}',
          color: AppColors.textColor,
          size: 14,
          weight: FontWeight.normal,
        ),
      ],
    );
  }
}
