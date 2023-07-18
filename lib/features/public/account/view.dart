import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hypertrip/domain/models/user/user_profile.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/features/login_by_email/view.dart';
import 'package:hypertrip/features/public/account/parts/avatar.dart';
import 'package:hypertrip/features/public/account/parts/information.dart';
import 'package:hypertrip/features/public/account/parts/privacy_bottomsheet.dart';
import 'package:hypertrip/features/public/account/parts/setting_item.dart';
import 'package:hypertrip/features/public/account/profile_bloc.dart';
import 'package:hypertrip/features/public/edit_profile/edit_profile_screen.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/app_bar.dart';
import 'package:hypertrip/widgets/app_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          ProfileBloc(GetIt.I.get<UserRepo>())..add(const FetchProfile()),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {},
        child: Scaffold(
          appBar: const MainAppBar(title: profileTitle,implyLeading: false),
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              print("state ${state.contacts.length}");
              return LoadableWidget(
                status: state.status,
                errorText: state.error,
                failureOnPress: () => context.read<ProfileBloc>().add(const FetchProfile()),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    AvatarProfile(url: state.userProfile.avatarUrl ?? ''),
                    20.height,
                    Center(
                      child: Text(
                        state.userProfile.displayName,
                        style: AppStyle.fontOpenSanBold
                            .copyWith(fontSize: 24, color: AppColors.textColor),
                      ),
                    ),
                    Center(
                      child: Text(
                        state.userProfile.role ?? '',
                        style: AppStyle.fontOpenSanRegular
                            .copyWith(fontSize: 16, color: AppColors.greyColor),
                      ),
                    ),
                    30.height,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Information(count: state.tourCount, status: 'joined'),
                        ],
                      ),
                    ),
                    30.height,
                    SettingItem(
                      icon: AppAssets.icons_ic_setting_svg,
                      greyColor: AppColors.primaryColor.withOpacity(0.2),
                      content: privacy,
                      callBack: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          useSafeArea: true,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return const PrivacyBottomSheet();
                          },
                        );
                      },
                    ),
                    SettingItem(
                      icon: AppAssets.icons_ic_user_svg,
                      greyColor: AppColors.yellow_2Color.withOpacity(0.2),
                      content: editProfile,
                      callBack: () {
                        Navigator.of(context)
                            .pushNamed(EditProfileScreen.routeName, arguments: state.userProfile)
                            .then((value) {
                          context.read<ProfileBloc>().add(UpdateProfile(value as UserProfile));
                        });
                      },
                    ),
                    60.height,
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            LoginByEmailPage.routeName, (route) => false); // remove all previous routes
                      },
                      child: Container(
                        height: 40,
                        width: 136,
                        margin: const EdgeInsets.symmetric(horizontal: 100),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(Radius.circular(16))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppAssets.icons_ic_sign_out_svg),
                            5.width,
                            Text(
                              signOut,
                              style: AppStyle.fontOpenSanSemiBold
                                  .copyWith(color: AppColors.primaryColor, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
