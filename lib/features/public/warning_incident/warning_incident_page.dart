import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hypertrip/domain/repositories/warning_incident_repository.dart';
import 'package:hypertrip/features/public/warning_incident/components/background_avatar.dart';
import 'package:hypertrip/features/public/warning_incident/components/weather_day.dart';
import 'package:hypertrip/features/public/warning_incident/interactor/warning_incident_bloc.dart';
import 'package:hypertrip/features/public/weather_detail/weather_detail_page.dart';
import 'package:hypertrip/widgets/app_bar.dart';
import 'package:hypertrip/widgets/app_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class WarningIncidentPage extends StatefulWidget {
  static const String routeName = '/warning-incident';
  const WarningIncidentPage({Key? key}) : super(key: key);

  @override
  State<WarningIncidentPage> createState() => _WarningIncidentPageState();
}

class _WarningIncidentPageState extends State<WarningIncidentPage> {
  final PageController _pageController = PageController(initialPage: 999);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          WarningIncidentBloc(GetIt.I.get<WarningIncidentRepository>())
            ..add(const FetchAllLocationTour()),
      child: BlocBuilder<WarningIncidentBloc, WarningIncidentState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const MainAppBar(implyLeading: true, title: 'Weather'),
            body: PageView.builder(
              controller: _pageController,
              itemCount: state.dataWeatherTour.length,
              reverse: true,
              onPageChanged: (value) {
                context.read<WarningIncidentBloc>().add(FetchDataWeather(value));
              },
              itemBuilder: (context, index) {
                final weatherResponse = state.dataWeatherTour[index];
                return LoadableWidget(
                  failureOnPress: () {},
                  errorText: '',
                  status: state.pageState,
                  loadingStack: true,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      (MediaQuery.of(context).padding.top).toInt().height,
                      16.height,
                      BackgroundAvatar(weatherResponse: weatherResponse),
                      32.height,
                      if (weatherResponse!.forecast.forecastDay.isNotEmpty)
                        WeatherDay(
                          weatherForecastDay: weatherResponse.forecast.forecastDay,
                          callback: () {
                            Navigator.of(context).pushNamed(
                              WeatherDetailPage.routeName,
                              arguments: weatherResponse,
                            );
                          },
                        ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
