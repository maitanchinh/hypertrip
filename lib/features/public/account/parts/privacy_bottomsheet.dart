import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/domain/validations/login_validator.dart';
import 'package:hypertrip/features/public/account/profile_bloc.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:nb_utils/nb_utils.dart';

class PrivacyBottomSheet extends StatefulWidget {
  const PrivacyBottomSheet({Key? key}) : super(key: key);

  @override
  State<PrivacyBottomSheet> createState() => _PrivacyBottomSheetState();
}

class _PrivacyBottomSheetState extends State<PrivacyBottomSheet> {
  final TextEditingController _textCurrentPassController = TextEditingController();
  final TextEditingController _textNewPassController = TextEditingController();
  final TextEditingController _textConfirmPassController = TextEditingController();

  @override
  void dispose() {
    _textCurrentPassController.dispose();
    _textNewPassController.dispose();
    _textConfirmPassController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ProfileBloc(GetIt.I.get<UserRepo>())..add(const FetchProfile()),
      child: BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
        if (state.pageCommand != null) {
          if (!state.setAutoValidateFormPass) {
            _textCurrentPassController.clear();
            _textNewPassController.clear();
            _textConfirmPassController.clear();
          }

          context.read<ProfileBloc>().add(const OnClearPageCommand());
        }
      }, builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.only(top: 56.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(10),
                  right: Radius.circular(10),
                ),
              ),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 16,
                      right: 16,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        children: [
                          16.height,
                          Text(
                            privacy,
                            style: AppStyle.fontOpenSanBold
                                .copyWith(color: AppColors.textColor, fontSize: 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                changePassword,
                                style: AppStyle.fontOpenSanSemiBold.copyWith(
                                  color: AppColors.greyColor,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 56,
                                child: TextButton(
                                  onPressed: () {
                                    context.read<ProfileBloc>().add(const OnSubmitUpdatePass());
                                  },
                                  child: Text(
                                    save,
                                    style: AppStyle.fontOpenSanSemiBold.copyWith(
                                      color: AppColors.primaryColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Form(
                            key: state.formPassKey,
                            autovalidateMode: state.setAutoValidateFormPass
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _textCurrentPassController,
                                  obscureText: true,
                                  validator: LoginValidator.validatePassword,
                                  onChanged: (value) =>
                                      context.read<ProfileBloc>().add(OnChangedCurrentPass(value)),
                                  decoration: InputDecoration(
                                    labelText: currentPassword,
                                    labelStyle: AppStyle.fontOpenSanLight
                                        .copyWith(color: AppColors.greyColor, fontSize: 16),
                                    hintText: '********',
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.greyColor),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.greyColor),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: _textNewPassController,
                                  obscureText: true,
                                  validator: LoginValidator.validatePassword,
                                  onChanged: (value) =>
                                      context.read<ProfileBloc>().add(OnChangedNewPass(value)),
                                  decoration: InputDecoration(
                                    labelText: newPassword,
                                    labelStyle: AppStyle.fontOpenSanLight
                                        .copyWith(color: AppColors.greyColor, fontSize: 16),
                                    hintText: '********',
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.greyColor),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.greyColor),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: _textConfirmPassController,
                                  obscureText: true,
                                  validator: LoginValidator.validatePassword,
                                  onChanged: (value) =>
                                      context.read<ProfileBloc>().add(OnChangedConfirmPass(value)),
                                  decoration: InputDecoration(
                                    labelText: confirmPassword,
                                    labelStyle: AppStyle.fontOpenSanLight
                                        .copyWith(color: AppColors.greyColor, fontSize: 16),
                                    hintText: '********',
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.greyColor),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.greyColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
