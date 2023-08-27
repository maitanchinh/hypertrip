import 'package:flutter/material.dart';
import 'package:hypertrip/domain/models/incidents/weather_alert.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/utils/date_time_utils.dart';
import 'package:hypertrip/widgets/app_bar.dart';
import 'package:hypertrip/widgets/space/gap.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../widgets/text/p_small_text.dart';
import '../../../widgets/text/p_text.dart';

class AlertDetail extends StatelessWidget {
  static const String routeName = '/alert-detail';
  final WeatherAlert alert;

  const AlertDetail({Key? key, required this.alert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLightColor,
      appBar: const MainAppBar(
          title: 'Disaster Information',
          implyLeading: true,
          backgroundColor: AppColors.primaryLightColor),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PText(
              'Overview',
              size: 24,
            ),
            Gap.k16.height,
            PSmallText(
              alert.description,
              size: 16,
              color: AppColors.greyColor,
            ),
            Gap.kSection.height,
            const PText(
              'Detail',
              size: 24,
            ),
            Gap.k16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gap.k16.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _detailWidget('Area', alert.areas),
                    Gap.k8.height,
                    _detailWidget('Urgency', alert.event),
                    Gap.k8.height,
                    _detailWidget('Effective',
                        DateTimeUtils.convertDateTimeString(alert.effective)),
                  ],
                ),
                (MediaQuery.of(context).size.width ~/ 3.5).width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _detailWidget('Severity', alert.severity),
                    Gap.k8.height,
                    _detailWidget('Certainty', alert.certainty),
                    Gap.k8.height,
                    _detailWidget('Expired',
                        DateTimeUtils.convertDateTimeString(alert.expires))
                  ],
                )
              ],
            ),
            32.height,
            const PText('Instruction', size: 24),
            Gap.k16.height,
            PSmallText(
              alert.instruction,
              size: 16,
              color: AppColors.greyColor,
            ),
          ],
        ),
      ),
    );
  }

  _detailWidget(String title, String content) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(children: [
        TextSpan(
            text: '$title\n',
            style: AppStyle.fontOpenSanSemiBold.copyWith(
                color: AppColors.textColor, fontSize: 16, height: 1.3)),
        TextSpan(
            text: content,
            style: AppStyle.fontOpenSanRegular.copyWith(
                color: AppColors.greyColor, fontSize: 16, height: 1.3))
      ]),
    );
  }
}
