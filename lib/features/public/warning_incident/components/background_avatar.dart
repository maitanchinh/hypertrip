import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/models/incidents/weather_forecast_day.dart';
import 'package:hypertrip/domain/models/incidents/weather_response.dart';
import 'package:hypertrip/features/public/warning_incident/components/address.dart';
import 'package:hypertrip/features/public/warning_incident/components/chart_temp.dart';
import 'package:hypertrip/features/public/warning_incident/components/item_wind.dart';
import 'package:hypertrip/features/public/warning_incident/components/termp.dart';
import 'package:hypertrip/features/public/warning_incident/components/time_address.dart';
import 'package:hypertrip/features/public/warning_incident/interactor/warning_incident_bloc.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:nb_utils/nb_utils.dart';

class BackgroundAvatar extends StatelessWidget {
  final WeatherResponse? weatherResponse;
  const BackgroundAvatar({Key? key, this.weatherResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WarningIncidentBloc, WarningIncidentState>(
      builder: (context, state) {
        return Stack(
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset(AppAssets.image_background_weather_png)),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16, top: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Address(address: weatherResponse?.location.name ?? ''),
                      TimeAddress(time: weatherResponse?.location.localtime ?? ''),
                    ],
                  ),
                ),
                20.height,
                Termp(
                    temp: weatherResponse?.current.tempC.toInt() ?? 0,
                    conditionText: weatherResponse?.current.condition?.text ?? ''),
                25.height,
                ItemWind(
                  hPa: weatherResponse?.current.pressureMb.toInt() ?? 0,
                  humidity: weatherResponse?.current.humidity ?? 0,
                  windKph: weatherResponse?.current.windKph ?? 0.0,
                ),
                25.height,
                ChartTemp(
                    weatherForecastDay: weatherResponse!.forecast.forecastDay.isNotEmpty
                        ? weatherResponse!.forecast.forecastDay.first
                        : WeatherForecastDay()),
              ],
            ),
          ],
        );
      },
    );
  }
}
