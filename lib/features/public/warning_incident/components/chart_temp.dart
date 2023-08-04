import 'package:flutter/material.dart';
import 'package:hypertrip/domain/models/incidents/weather_forecast_day.dart';
import 'package:hypertrip/domain/models/incidents/weather_hour.dart';
import 'package:hypertrip/features/public/warning_incident/components/progress_hour_temp.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:nb_utils/nb_utils.dart';

class ChartTemp extends StatelessWidget {
  final WeatherForecastDay weatherForecastDay;

  const ChartTemp({Key? key, required this.weatherForecastDay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<double> averages = averagesTemp();
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Temperature",
                  style: AppStyle.fontOpenSanSemiBold.copyWith(fontSize: 16, color: AppColors.textColor)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...averages.mapIndexed((index, e) {
                    String title = '';
                    if (index == 0) {
                      title = 'Morning';
                    } else if (index == 1) {
                      title = 'Afternoon';
                    } else if (index == 2) {
                      title = 'Evening';
                    } else if (index == 3) {
                      title = 'Night';
                    }

                    double percentage = calculateTemperaturePercentage(e);

                    return ProgressHourTermp(value: percentage, temp: e.toInt(), title: title);
                  })
                ],
              ),
            ],
          ),
        ));
  }

  double calculateTemperaturePercentage(double currentTemperature) {
    double minTemperature = -89; // Giá trị nhiệt độ tối thiểu cố định
    double maxTemperature = 53.2; // Giá trị nhiệt độ tối đa cố định

    return (currentTemperature - minTemperature) / (maxTemperature - minTemperature);
  }

  List<double> averagesTemp() {
    List<double> averages = [];

    for (int i = 0; i < weatherForecastDay.hours.length; i += 6) {
      int endIndex = i + 6;
      if (endIndex > weatherForecastDay.hours.length) {
        endIndex = weatherForecastDay.hours.length;
      }

      List<WeatherHour> group = weatherForecastDay.hours.sublist(i, endIndex);
      double average = group.map((hour) => hour.tempC).reduce((a, b) => a + b) / group.length;
      averages.add(average);
    }
    return averages;
  }
}

extension IterableIndexed<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E element) f) sync* {
    var index = 0;
    for (final element in this) {
      yield f(index, element);
      index++;
    }
  }
}
