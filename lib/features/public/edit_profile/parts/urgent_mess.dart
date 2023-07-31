import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/p_text_form_field.dart';

import '../../../../widgets/text/p_small_text.dart';
import '../../../../widgets/text/p_text.dart';

class UrgentMess extends StatefulWidget {
  const UrgentMess({Key? key}) : super(key: key);

  @override
  State<UrgentMess> createState() => _UrgentMessState();
}

class _UrgentMessState extends State<UrgentMess> {
  final TextEditingController _textMessageController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textMessageController.text = '';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textMessageController.dispose();
    super.dispose();
  }

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
                child: const PText(
                  'Save',
                  size: 16,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
        PTextFormField(
          controller: _textMessageController,
          onChange: (value) {},
          label: urgentMsg,
        )
        // const PSmallText(
        //   'Compose the message you want to send in an emergency situation',
        //   size: 16,
        // ),
      ],
    );
  }
}
