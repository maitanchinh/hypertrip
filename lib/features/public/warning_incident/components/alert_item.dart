import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hypertrip/domain/models/incidents/weather_alert.dart';
import 'package:hypertrip/features/public/alert_detail/alert_detail.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/utils/date_time_utils.dart';
import 'package:hypertrip/widgets/image/image.dart';
import 'package:nb_utils/nb_utils.dart';

class AlertItem extends StatelessWidget {
  final WeatherAlert alert;

  const AlertItem({Key? key, required this.alert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(AlertDetail.routeName,arguments: alert),
      child: Container(
        constraints: const BoxConstraints(minHeight: 88),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16))),
                child: commonCachedNetworkImage(
                  "",
                  width: 100,
                  height: 100,
                )),
            8.width,
            SizedBox(
              width: MediaQuery.of(context).size.width - 172,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  16.height,
                  Text(alert.areas,style: AppStyle.fontOpenSanSemiBold.copyWith(fontSize: 16,color: AppColors.textColor)),
                  6.height,
                  Text(DateTimeUtils.convertDateTimeString(alert.expires),style: AppStyle.fontOpenSanSemiBold.copyWith(fontSize: 16,color: AppColors.greyColor)),
                  6.height,
                  Text(alert.event,style: AppStyle.fontOpenSanSemiBold.copyWith(fontSize: 16,color: AppColors.secondaryColor)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
