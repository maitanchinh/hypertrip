import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/validations/login_validator.dart';
import 'package:hypertrip/features/public/edit_profile/edit_profile_bloc.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/utils/message.dart';

class ContactInfo extends StatefulWidget {
  const ContactInfo({Key? key}) : super(key: key);

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  final List<TextEditingController> lstContactController = [];

  final List<FocusNode> lstFocusNode = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        if (lstContactController.length < state.contacts.length) {
          lstContactController.clear();

          for (final contact in state.contacts) {
            lstContactController.add(TextEditingController(text: contact));
            lstFocusNode.add(FocusNode());
          }
        }

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  emergencyContact,
                  style: AppStyle.fontOpenSanSemiBold.copyWith(
                    color: AppColors.greyColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                    width: 56,
                    child: TextButton(
                        onPressed: () =>
                            context.read<EditProfileBloc>().add(const OnUpdateContact()),
                        child: Text(
                          save,
                          style: AppStyle.fontOpenSanSemiBold.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                          ),
                        )))
              ],
            ),
            Column(
              children: state.contacts.asMap().entries.map((entry) {
                final index = entry.key;
                final contact = entry.value;
                final controller = lstContactController[index];
                final focusNode = lstFocusNode[index];
                return Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    validator: LoginValidator.validatePhoneNumber,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) =>
                        context.read<EditProfileBloc>().add(OnChangedContact(index, value)),
                    decoration: InputDecoration(
                      labelText: 'Contact',
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
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 56,
                  child: TextButton(
                    onPressed: () => context.read<EditProfileBloc>().add(const AddNewContact()),
                    child: Text(
                      add,
                      style: AppStyle.fontOpenSanSemiBold.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    for (final controller in lstContactController) {
      controller.dispose();
    }

    super.dispose();
  }
}
