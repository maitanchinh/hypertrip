import 'package:flutter/material.dart';
import 'package:hypertrip/domain/models/incidents/weather_forecast_day.dart';
import 'package:hypertrip/features/public/warning_incident/components/weather_day.dart';
import 'package:hypertrip/features/public/weather_detail/components/item_temp_hour_horizontal.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/date_time_utils.dart';
import 'package:hypertrip/widgets/app_bar.dart';
import 'package:hypertrip/widgets/space/gap.dart';
import 'package:nb_utils/nb_utils.dart';

class WeatherDetailPage extends StatelessWidget {
  static const String routeName = '/weather-detail';
  final String title;
  final List<WeatherForecastDay> forecastDay;

  const WeatherDetailPage({Key? key, this.forecastDay = const [], this.title = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        backgroundColor: AppColors.primaryLightColor,
        appBar: MainAppBar(implyLeading: true, title: title,backgroundColor: AppColors.primaryLightColor),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              WeatherDay(showAllDay: false, weatherForecastDay: forecastDay,color: null),
              Gap.kSection.height,
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(0),
                  itemCount: forecastDay.length,
                  itemBuilder: (context, index) {
                    final weatherForecastDay = forecastDay[index];
                    return ItemTempHourHorizontal(
                        content: DateTimeUtils.convertTimeToDayOfWeek(
                            weatherForecastDay.hours.first.time),
                        day: DateTimeUtils.convertTimeToDayAndMonthString(
                            weatherForecastDay.hours.first.time),
                        temp: weatherForecastDay.hours[12].tempC.toInt(),
                        icon: 'https:${weatherForecastDay.hours[12].condition?.icon}');
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return 25.height;
                  },
                ),
              ),
              20.height,
            ],
          ),
        ));
  }
}
