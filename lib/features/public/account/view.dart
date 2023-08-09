import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:hypertrip/domain/models/user/user_profile.dart';
import 'package:hypertrip/domain/repositories/foursquare_repo.dart';
import 'package:hypertrip/domain/repositories/group_repo.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/features/login_by_email/view.dart';
import 'package:hypertrip/features/public/account/parts/avatar.dart';
import 'package:hypertrip/features/public/account/parts/emergency_bottomsheet.dart';
import 'package:hypertrip/features/public/account/parts/information.dart';
import 'package:hypertrip/features/public/account/parts/privacy_bottomsheet.dart';
import 'package:hypertrip/features/public/account/parts/setting_item.dart';
import 'package:hypertrip/features/public/account/parts/share_location_map.dart';
import 'package:hypertrip/features/public/account/profile_bloc.dart';
import 'package:hypertrip/features/public/edit_profile/edit_profile_screen.dart';
import 'package:hypertrip/features/public/permission/cubit.dart';
import 'package:hypertrip/features/public/permission/state.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/app_bar.dart';
import 'package:hypertrip/widgets/app_widget.dart';
import 'package:hypertrip/widgets/space/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../widgets/text/p_text.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key});

  StreamSubscription<Position>? _locationSubscription;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProfileBloc(
          GetIt.I.get<UserRepo>(), GetIt.I.get<FoursquareRepo>(), GetIt.I.get<GroupRepo>())
        ..add(const FetchProfile()),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {},
        child: Scaffold(
          appBar: const MainAppBar(title: profileTitle, implyLeading: false),
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
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
                      child: PText(
                        state.userProfile.displayName,
                        size: 24,
                      ),
                    ),
                    Gap.k8.height,
                    Center(
                      child: PText(
                        state.userProfile.role ?? '',
                        weight: FontWeight.normal,
                        color: AppColors.greyColor,
                      ),
                    ),
                    30.height,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Information(count: state.tourCount, status: 'Joined Tour'),
                        ],
                      ),
                    ),
                    30.height,
                    SettingItem(
                      icon: AppAssets.icons_ic_setting_svg,
                      greyColor: AppColors.primaryColor.withOpacity(0.2),
                      iconColor: AppColors.primaryColor,
                      content: privacy,
                      callBack: () {
                        showCupertinoModalBottomSheet(
                          // isScrollControlled: true,
                          context: context,
                          // useSafeArea: true,
                          expand: true,
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
                      iconColor: AppColors.secondaryColor,
                      content: editProfile,
                      callBack: () {
                        Navigator.of(context)
                            .pushNamed(EditProfileScreen.routeName, arguments: state.userProfile)
                            .then((value) {
                          context.read<ProfileBloc>().add(UpdateProfile(value as UserProfile));
                        });
                      },
                    ),
                    SettingItem(
                      icon: AppAssets.icons_ic_emergency_svg,
                      greyColor: AppColors.yellow_2Color.withOpacity(0.2),
                      iconColor: AppColors.redColor,
                      content: emergency,
                      callBack: () {
                        showCupertinoModalBottomSheet(
                          // isScrollControlled: true,
                          context: context,
                          // useSafeArea: true,
                          expand: true,
                          backgroundColor: Colors.transparent,

                          builder: (BuildContext context) {
                            return const EmergencyBottomSheet();
                          },
                        );
                      },
                    ),
                    60.height,
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(LoginByEmailPage.routeName,
                            (route) => false); // remove all previous routes
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
                            SizedBox(
                              width: 24,
                              child: Transform.scale(
                                scale: 0.8,
                                child: SvgPicture.asset(
                                  AppAssets.icons_ic_sign_out_svg,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            5.width,
                            PText(
                              signOut,
                              color: AppColors.primaryColor,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ),
                    Gap.k16.height,
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('location')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _getLocation(context, state.userProfile);
                                  _listenLocation(state
                                      .userProfile); // remove all previous routes
                                },
                                child: Container(
                                  height: 40,
                                  // margin: const EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor
                                          .withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      PText(
                                        'Share',
                                        color: AppColors.primaryColor,
                                        size: 16,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Gap.k16.width,
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ShareLocationMap(
                                          userId: snapshot.data!.docs[0]
                                              .id))); // remove all previous routes
                                },
                                child: Container(
                                  height: 40,
                                  // margin: const EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor
                                          .withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      PText(
                                        'View',
                                        color: AppColors.primaryColor,
                                        size: 16,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Gap.k16.width,
                              GestureDetector(
                                onTap: () {
                                  _stopListeningLocation();
                                },
                                child: Container(
                                  height: 40,
                                  // margin: const EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor
                                          .withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      PText(
                                        'Stop',
                                        color: AppColors.primaryColor,
                                        size: 16,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        })
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _getLocation(BuildContext context, UserProfile user) async {
    try {
      final cubit = BlocProvider.of<CurrentLocationCubit>(context);
      Position currentLocation =
          (cubit.state as LoadCurrentLocationSuccessState).location;
      await FirebaseFirestore.instance.collection('location').doc(user.id).set(
          {'lat': currentLocation.latitude, 'lng': currentLocation.longitude},
          SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  // Future<void> _listenLocation(UserProfile user) async {
  //   Geolocator.getPositionStream().listen((Position position) async {
  //     await FirebaseFirestore.instance.collection('location').doc(user.id).set(
  //         {'lat': position.latitude, 'lng': position.longitude},
  //         SetOptions(merge: true));
  //   });
  // }
  void _listenLocation(UserProfile user) {
    _locationSubscription =
        Geolocator.getPositionStream().listen((Position position) async {
      await FirebaseFirestore.instance.collection('location').doc(user.id).set(
          {'lat': position.latitude, 'lng': position.longitude},
          SetOptions(merge: true));
    });
  }

  void _stopListeningLocation() {
    if (_locationSubscription != null) {
      _locationSubscription!.cancel();
      _locationSubscription = null;
    }
  }
}
