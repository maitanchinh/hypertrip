import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:hypertrip/domain/repositories/foursquare_repo.dart';
import 'package:hypertrip/domain/repositories/group_repo.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/features/public/account/profile_bloc.dart';
import 'package:hypertrip/features/root/cubit.dart';
import 'package:hypertrip/features/root/state.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/app_widget.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../domain/models/user/user_profile.dart';
import '../../../../widgets/text/p_text.dart';
import '../../permission/cubit.dart';
import '../../permission/state.dart';

class EmergencyBottomSheet extends StatefulWidget {
  const EmergencyBottomSheet({Key? key}) : super(key: key);

  @override
  State<EmergencyBottomSheet> createState() => _PrivacyBottomSheetState();
}

class _PrivacyBottomSheetState extends State<EmergencyBottomSheet> {
  StreamSubscription<Position>? _locationSubscription;

  bool isGetLocation = false;

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
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

  void _listenLocation(UserProfile user) {
    setState(() {
      isGetLocation = true;
    });

    _locationSubscription =
        Geolocator.getPositionStream().listen((Position position) async {
          if(isGetLocation) {
            await FirebaseFirestore.instance.collection('location').doc(user.id).set(
          {'lat': position.latitude, 'lng': position.longitude},
          SetOptions(merge: true));
          }
    });
  }

  void _stopListeningLocation(UserProfile user) {
    setState(() {
      isGetLocation = false;
    });

    FirebaseFirestore.instance.collection('location').doc(user.id).delete();
  }

  Future<void> checkDocumentExists() async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('yourCollection')
        .doc('yourDocumentId');

    DocumentSnapshot docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      print('Document exists');
    } else {
      print('Document does not exist');
    }
  }

  @override
  Widget build(BuildContext context) {
    var rootCubit = BlocProvider.of<RootCubit>(context);
    var rootState = rootCubit.state as RootSuccessState;
    print("rootState ${rootState.group?.id ?? ''}");
    return BlocProvider.value(
      value: ProfileBloc(GetIt.I.get<UserRepo>(), GetIt.I.get<FoursquareRepo>(),
          GetIt.I.get<GroupRepo>())
        ..add(const FetchProfile()),
      child:
          BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
        if (state.pageCommand != null) {
          context.read<ProfileBloc>().add(const OnClearPageCommand());
        }
      }, builder: (context, state) {
        print(state.userProfile.id);
        return LoadableWidget(
          status: state.status,
          errorText: '',
          failureOnPress: () {},
          child: GestureDetector(
            onTap: () {},
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10),
                      right: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      (kToolbarHeight ~/ 2).height,
                      const PText(emergency),
                      40.height,
                      GestureDetector(
                        onTap: () =>
                            context.read<ProfileBloc>().add(const OnOpenMap()),
                        child: const PText(
                          sendEmergency,
                          size: 16,
                          color: AppColors.greyColor,
                        ),
                      ),
                      60.height,
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('location')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              bool profileExists = snapshot.data!.docs
                                  .any((doc) => doc.id == state.userProfile.id);

                              return !profileExists
                                  ? GestureDetector(
                                      onTap: () {
                                        context.read<ProfileBloc>().add(
                                            OnSubmitSendEmergency(
                                                groupId:
                                                    rootState.group?.id ?? ''));
                                        _getLocation(
                                            context, state.userProfile);
                                        _listenLocation(state.userProfile);
                                      },
                                      child: Container(
                                        height: 56,
                                        // width: 136,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 100),
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryColor
                                                .withOpacity(0.2),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(16))),
                                        child: const Center(
                                          child: PText(
                                            send,
                                            color: AppColors.primaryColor,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ).paddingSymmetric(horizontal: 16)
                                  : GestureDetector(
                                      onTap: () {
                                        _stopListeningLocation(
                                            state.userProfile);
                                      },
                                      child: Container(
                                        height: 56,
                                        // width: 136,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 100),
                                        decoration: BoxDecoration(
                                            color: redColor.withOpacity(0.2),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(16))),
                                        child: const Center(
                                          child: PText(
                                            stopShareLocation,
                                            color: redColor,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ).paddingSymmetric(horizontal: 16);
                            } else if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            } else {
                              return const CircularProgressIndicator();
                            }
                          })
                    ],
                  )),
            ),
          ),
        );
      }),
    );
  }
}
