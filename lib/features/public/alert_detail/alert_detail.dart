import 'package:flutter/material.dart';
import 'package:hypertrip/domain/models/incidents/weather_alert.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/utils/date_time_utils.dart';
import 'package:hypertrip/widgets/app_bar.dart';
import 'package:nb_utils/nb_utils.dart';

class AlertDetail extends StatelessWidget {
  static const String routeName = '/alert-detail';
  final WeatherAlert alert;

  const AlertDetail({Key? key, required this.alert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLightColor,
      appBar: MainAppBar(
          title: 'Disaster Information',
          implyLeading: true,
          backgroundColor: AppColors.primaryLightColor),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Overview',
                style: AppStyle.fontOpenSanBold.copyWith(color: AppColors.textColor, fontSize: 24)),
            Text(alert.description,
                style:
                    AppStyle.fontOpenSanRegular.copyWith(color: AppColors.greyColor, fontSize: 16)),
            32.height,
            Text('Detail',
                style: AppStyle.fontOpenSanBold.copyWith(color: AppColors.textColor, fontSize: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                10.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _detailWidget('Area', alert.areas),
                    10.height,
                    _detailWidget('Urgency', alert.event),
                    10.height,
                    _detailWidget(
                        'Effective', DateTimeUtils.convertDateTimeString(alert.effective)),
                  ],
                ),
                (MediaQuery.of(context).size.width~/3.5).width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _detailWidget('Severity', alert.severity),
                    10.height,
                    _detailWidget('Certainty', alert.certainty),
                    10.height,
                    _detailWidget('Expired', DateTimeUtils.convertDateTimeString(alert.expires))
                  ],
                )
              ],
            ),
            32.height,
            Text('Instruction',
                style: AppStyle.fontOpenSanBold.copyWith(color: AppColors.textColor, fontSize: 24)),
            Text(alert.instruction,
                style:
                    AppStyle.fontOpenSanRegular.copyWith(color: AppColors.greyColor, fontSize: 16)),
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
            style: AppStyle.fontOpenSanSemiBold.copyWith(color: AppColors.textColor, fontSize: 16,height: 1.3)),
        TextSpan(
            text: content,
            style: AppStyle.fontOpenSanRegular.copyWith(color: AppColors.greyColor, fontSize: 16,height: 1.3))
      ]),
    );
  }
}
