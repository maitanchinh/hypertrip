import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hypertrip/domain/models/user/user_profile.dart';
import 'package:hypertrip/domain/repositories/tour_repo.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/features/public/edit_profile/edit_profile_bloc.dart';
import 'package:hypertrip/features/public/edit_profile/parts/contact_info.dart';
import 'package:hypertrip/features/public/edit_profile/parts/urgent_mess.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/utils/page_command.dart';
import 'package:hypertrip/widgets/app_bar.dart';
import 'package:nb_utils/nb_utils.dart';

import 'parts/picker_photo_dialog.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/edit-profile';
  final UserProfile userProfile;

  const EditProfileScreen(this.userProfile, {Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _textFirstNameController = TextEditingController();
  final TextEditingController _textLastNameController = TextEditingController();
  final TextEditingController _textAddressController = TextEditingController();
  final TextEditingController _textGenderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textFirstNameController.text = widget.userProfile.firstName ?? '';
    _textLastNameController.text = widget.userProfile.lastName ?? '';
    _textAddressController.text = widget.userProfile.address ?? '';
    _textGenderController.text = widget.userProfile.gender ?? '';
  }

  @override
  void dispose() {
    _textFirstNameController.dispose();
    _textLastNameController.dispose();
    _textAddressController.dispose();
    _textGenderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          EditProfileBloc(GetIt.I.get<UserRepo>(), GetIt.I.get<TourRepo>())
            ..add(FetchProfile(widget.userProfile)),
      child: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state.pageCommand is PageCommandNavigatorPage) {
            changePage(state.pageCommand as PageCommandNavigatorPage, context);
          }

          context.read<EditProfileBloc>().add(const OnClearPageCommand());
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: MainAppBar(
                title: profileTitle,
                implyLeading: true,
                onTap: () => context.read<EditProfileBloc>().add(
                      OnNavigateToPage(
                        page: null,
                        argument: state.userProfile,
                      ),
                    ),
              ),
              body: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  20.height,
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      var dialogImagePicker = PickerPhotoDialog(
                        isMultiImage: false,
                        hasCrop: false,
                        title: uploadPhoto,
                        numberImages: 1,
                        callback: (source) {
                          Navigator.of(context).pop();
                          context.read<EditProfileBloc>().add(OnUpdateAvatar(source));
                        },
                      );

                      showCupertinoModalPopup(
                          context: context, builder: (context) => dialogImagePicker);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        state.fileNewUrl != null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: FileImage(state.fileNewUrl!),
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl: state.userProfile.avatarUrl ?? '',
                                width: 100,
                                height: 100,
                                imageBuilder: (context, imageProvider) => Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: AppColors.grey2Color,
                                    ),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: AppColors.grey2Color,
                                    ),
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: AppColors.grey2Color,
                                    ),
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                        10.width,
                        Text(
                          photoUpload,
                          style: AppStyle.fontOpenSanRegular
                              .copyWith(fontSize: 16, color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: _textFirstNameController,
                    onChanged: (value) =>
                        context.read<EditProfileBloc>().add(OnChangedFirstName(value)),
                    style: AppStyle.fontOpenSanRegular
                        .copyWith(color: AppColors.textColor, fontSize: 16),
                    decoration: InputDecoration(
                      labelText: firstName,
                      labelStyle: AppStyle.fontOpenSanLight
                          .copyWith(color: AppColors.textGreyColor, fontSize: 16),
                      hintText: '12345678',
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greyColor),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greyColor),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _textLastNameController,
                    onChanged: (value) =>
                        context.read<EditProfileBloc>().add(OnChangedLastName(value)),
                    style: AppStyle.fontOpenSanRegular
                        .copyWith(color: AppColors.textColor, fontSize: 16),
                    decoration: InputDecoration(
                      labelText: lastName,
                      labelStyle: AppStyle.fontOpenSanLight
                          .copyWith(color: AppColors.textGreyColor, fontSize: 16),
                      hintText: '12345678',
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greyColor),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greyColor),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _textAddressController,
                    onChanged: (value) =>
                        context.read<EditProfileBloc>().add(OnChangedAddress(value)),
                    style: AppStyle.fontOpenSanRegular
                        .copyWith(color: AppColors.textColor, fontSize: 16),
                    decoration: InputDecoration(
                      labelText: 'Address',
                      labelStyle: AppStyle.fontOpenSanLight
                          .copyWith(color: AppColors.textGreyColor, fontSize: 16),
                      hintText: '12345678',
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greyColor),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greyColor),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _textGenderController,
                    onChanged: (value) =>
                        context.read<EditProfileBloc>().add(OnChangedGender(value)),
                    style: AppStyle.fontOpenSanRegular
                        .copyWith(color: AppColors.textColor, fontSize: 16),
                    decoration: InputDecoration(
                      labelText: gender,
                      labelStyle: AppStyle.fontOpenSanLight
                          .copyWith(color: AppColors.greyColor, fontSize: 16),
                      hintText: '12345678',
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greyColor),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greyColor),
                      ),
                    ),
                  ),
                  // TextFormField(
                  //   initialValue: 'maitanchinh@gmail.com',
                  //   style: AppStyle.fontOpenSanRegular
                  //       .copyWith(color: AppColors.textPrimaryColor, fontSize: 16),
                  //   decoration: InputDecoration(
                  //     labelText: 'Email',
                  //     labelStyle: AppStyle.fontOpenSanLight
                  //         .copyWith(color: AppColors.textGrey_2Color, fontSize: 16),
                  //     hintText: '12345678',
                  //     focusedBorder: const UnderlineInputBorder(
                  //       borderSide: BorderSide(color: AppColors.greyColor),
                  //     ),
                  //     enabledBorder: const UnderlineInputBorder(
                  //       borderSide: BorderSide(color: AppColors.greyColor),
                  //     ),
                  //   ),
                  // ),
                  // TextFormField(
                  //   initialValue: '+84 389 376 290',
                  //   style: AppStyle.fontOpenSanRegular
                  //       .copyWith(color: AppColors.textPrimaryColor, fontSize: 16),
                  //   decoration: InputDecoration(
                  //     labelText: 'Phone',
                  //     labelStyle: AppStyle.fontOpenSanLight
                  //         .copyWith(color: AppColors.textGrey_2Color, fontSize: 16),
                  //     hintText: '12345678',
                  //     focusedBorder: const UnderlineInputBorder(
                  //       borderSide: BorderSide(color: AppColors.greyColor),
                  //     ),
                  //     enabledBorder: const UnderlineInputBorder(
                  //       borderSide: BorderSide(color: AppColors.greyColor),
                  //     ),
                  //   ),
                  // ),
                  50.height,
                  GestureDetector(
                    onTap: () => context.read<EditProfileBloc>().add(const OnSubmitUpdateInfo()),
                    child: Container(
                      height: 40,
                      width: 136,
                      margin: const EdgeInsets.symmetric(horizontal: 120),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(Radius.circular(16))),
                      child: Center(
                        child: Text(
                          save,
                          style: AppStyle.fontOpenSanSemiBold
                              .copyWith(color: AppColors.primaryColor, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  if (state.contacts.isNotEmpty) const ContactInfo(),
                  10.height,
                  const UrgentMess(),
                  100.height,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void changePage(PageCommandNavigatorPage page, BuildContext context) {
    if (page.page == null) {
      Navigator.of(context).pop(page.argument);
    }
  }
}
