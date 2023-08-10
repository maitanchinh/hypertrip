import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

import '../../../../widgets/text/p_text.dart';

class EmergencyBottomSheet extends StatefulWidget {
  const EmergencyBottomSheet({Key? key}) : super(key: key);

  @override
  State<EmergencyBottomSheet> createState() => _PrivacyBottomSheetState();
}

class _PrivacyBottomSheetState extends State<EmergencyBottomSheet> {
  final TextEditingController _textCurrentPassController =
      TextEditingController();
  final TextEditingController _textNewPassController = TextEditingController();
  final TextEditingController _textConfirmPassController =
      TextEditingController();

  @override
  void dispose() {
    _textCurrentPassController.dispose();
    _textNewPassController.dispose();
    _textConfirmPassController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var rootCubit = BlocProvider.of<RootCubit>(context);
    var rootState = rootCubit.state as RootSuccessState;
    print("rootState ${rootState.group?.id ?? ''}");
    return BlocProvider.value(
      value: ProfileBloc(GetIt.I.get<UserRepo>(), GetIt.I.get<FoursquareRepo>(),
          GetIt.I.get<GroupRepo>()),
      child:
          BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
        if (state.pageCommand != null) {
          context.read<ProfileBloc>().add(const OnClearPageCommand());
        }
      }, builder: (context, state) {
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
                      GestureDetector(
                        onTap: () => context.read<ProfileBloc>().add(
                            OnSubmitSendEmergency(
                                groupId: rootState.group?.id ?? '')),
                        child: Container(
                          height: 40,
                          width: 136,
                          margin: const EdgeInsets.symmetric(horizontal: 100),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16))),
                          child: const Center(
                            child: PText(
                              send,
                              color: AppColors.primaryColor,
                              size: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ),
        );
      }),
    );
  }
}
