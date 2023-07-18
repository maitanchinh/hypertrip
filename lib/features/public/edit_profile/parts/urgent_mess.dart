import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';

class UrgentMess extends StatelessWidget {
  const UrgentMess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: 'Urgent message',
                style: AppStyle.fontOpenSanSemiBold.copyWith(
                  color: AppColors.textColor,
                  fontSize: 16,
                ),
              ),
              TextSpan(
                text: '*',
                style: AppStyle.fontOpenSanSemiBold.copyWith(
                  color: AppColors.red_2Color,
                  fontSize: 16,
                ),
              )
            ])),
            SizedBox(
              width: 56,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Save',
                  style: AppStyle.fontOpenSanSemiBold.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        Text(
          'Compose the message you want to send in an emergency situation',
          style: AppStyle.fontOpenSanRegular.copyWith(
            color: AppColors.greyColor,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
