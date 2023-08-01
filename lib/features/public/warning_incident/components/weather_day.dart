import 'package:flutter/material.dart';
import 'package:hypertrip/domain/models/incidents/weather_forecast_day.dart';
import 'package:hypertrip/features/public/warning_incident/components/item_temp_hour.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../widgets/space/gap.dart';
import '../../../../widgets/text/p_text.dart';

class WeatherDay extends StatelessWidget {
  final bool showAllDay;
  final List<WeatherForecastDay> weatherForecastDay;
  final VoidCallback? callback;
  final Color? color;

  const WeatherDay({
    Key? key,
    this.showAllDay = true,
    required this.weatherForecastDay,
    this.callback,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: const BorderRadius.all(Radius.circular(16))),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const PText(
                "Today",
                size: 16,
              ),
              if (showAllDay)
                SizedBox(
                  width: 100,
                  child: TextButton(
                    onPressed: callback,
                    child: PText(
                      "Next ${weatherForecastDay.length} Days",
                      size: 16,
                      decoration: TextDecoration.underline,
                      color: AppColors.primaryColor,
                      // style: AppStyle.fontOpenSanSemiBold.copyWith(
                      //   fontSize: 16,
                      //   color: AppColors.primaryColor,
                      //   decorationStyle: TextDecorationStyle.solid,
                      //   decoration: TextDecoration.underline,
                      // ),
                    ),
                  ),
                )
            ],
          ),
          if (weatherForecastDay.first.hours.isNotEmpty)
            SizedBox(
              height: 116,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: weatherForecastDay.first.hours.length,
                itemBuilder: (context, index) {
                  final weatherHour = weatherForecastDay.first.hours[index];
                  return ItemTempHour(
                      hour: weatherHour.time,
                      temp: weatherHour.tempC.toInt(),
                      icon: 'https:${weatherHour.condition?.icon}');
                },
                separatorBuilder: (BuildContext context, int index) {
                  return 16.width;
                },
              ),
            )
        ],
      ),
    );
  }
}
