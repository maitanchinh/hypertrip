import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hypertrip/domain/models/incidents/warning_argument.dart';
import 'package:hypertrip/domain/repositories/warning_incident_repository.dart';
import 'package:hypertrip/features/public/warning_incident/components/alert_item.dart';
import 'package:hypertrip/features/public/warning_incident/components/background_avatar.dart';
import 'package:hypertrip/features/public/warning_incident/components/weather_day.dart';
import 'package:hypertrip/features/public/warning_incident/interactor/warning_incident_bloc.dart';
import 'package:hypertrip/features/public/weather_detail/weather_detail_page.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/widgets/app_bar.dart';
import 'package:hypertrip/widgets/app_widget.dart';
import 'package:hypertrip/widgets/space/gap.dart';
import 'package:nb_utils/nb_utils.dart';

class WarningIncidentPage extends StatefulWidget {
  static const String routeName = '/warning-incident';

  final WarningArgument args;

  const WarningIncidentPage({Key? key, required this.args}) : super(key: key);

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
            ..add(FetchAllLocationTour(widget.args.locationTour))
            ..add(FetchAllAlert(widget.args.tripId)),
      child: BlocBuilder<WarningIncidentBloc, WarningIncidentState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const MainAppBar(
                implyLeading: true,
                title: 'Weather Alert',
                backgroundColor: AppColors.primaryLightColor),
            backgroundColor: AppColors.primaryLightColor,
            body: (state.alerts.isNotEmpty)
                ? Container(
                    margin: const EdgeInsets.only(top: 35, bottom: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: const BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start, children: [
                      16.height,
                      Text(
                        'Disaster Forecast',
                        style: AppStyle.fontOpenSanSemiBold
                            .copyWith(color: AppColors.textColor, fontSize: 16),
                      ),
                      Gap.k8.height,
                      ...state.alerts.map((e) {
                        return AlertItem(alert: e).paddingSymmetric(vertical: 10);
                      }).toList()
                    ]),
                  )
                : const Center(child: Text("No Data")),
            // body: PageView.builder(
            //   controller: _pageController,
            //   itemCount: state.dataWeatherTour.length,
            //   onPageChanged: (value) {
            //     context
            //         .read<WarningIncidentBloc>()
            //         .add(FetchDataWeather(value));
            //   },
            //   itemBuilder: (context, index) {
            //     final weatherResponse = state.dataWeatherTour[index];
            //     return LoadableWidget(
            //       failureOnPress: () {},
            //       errorText: '',
            //       status: state.pageState,
            //       loadingStack: true,
            //       child: ListView(
            //         padding: const EdgeInsets.symmetric(horizontal: 16),
            //         children: [
            //           (MediaQuery.of(context).padding.top).toInt().height,
            //           // 16.height,
            //           if (state.alerts.isNotEmpty)
            //             Container(
            //               margin: const EdgeInsets.only(top: 35, bottom: 20),
            //               padding: const EdgeInsets.symmetric(horizontal: 16),
            //               decoration: const BoxDecoration(
            //                   color: Colors.white,
            //                   borderRadius:
            //                       BorderRadius.all(Radius.circular(16))),
            //               child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     16.height,
            //                     Text(
            //                       'Disaster Forecast',
            //                       style: AppStyle.fontOpenSanSemiBold.copyWith(
            //                           color: AppColors.textColor, fontSize: 16),
            //                     ),
            //                     Gap.k8.height,
            //                     ...state.alerts.map((e) {
            //                       return AlertItem(alert: e)
            //                           .paddingSymmetric(vertical: 10);
            //                     }).toList()
            //                   ]),
            //             )
            //           else
            //             const Center(child: Text("No Data")),
            //           12.height,
            //           BackgroundAvatar(weatherResponse: weatherResponse),
            //           32.height,
            //           if (weatherResponse!.forecast.forecastDay.isNotEmpty)
            //             WeatherDay(
            //               weatherForecastDay:
            //                   weatherResponse.forecast.forecastDay,
            //               color: Colors.white,
            //               callback: () {
            //                 Navigator.of(context).pushNamed(
            //                   WeatherDetailPage.routeName,
            //                   arguments: weatherResponse,
            //                 );
            //               },
            //             ),
            //           // if (state.alerts.isNotEmpty)
            //           //   Container(
            //           //     margin: const EdgeInsets.only(top: 35, bottom: 20),
            //           //     padding: const EdgeInsets.symmetric(horizontal: 16),
            //           //     decoration: const BoxDecoration(
            //           //         color: Colors.white,
            //           //         borderRadius:
            //           //             BorderRadius.all(Radius.circular(16))),
            //           //     child: Column(
            //           //         crossAxisAlignment: CrossAxisAlignment.start,
            //           //         children: [
            //           //           16.height,
            //           //           Text(
            //           //             'Disaster Forecast',
            //           //             style: AppStyle.fontOpenSanSemiBold.copyWith(
            //           //                 color: AppColors.textColor, fontSize: 16),
            //           //           ),
            //           //           Gap.k8.height,
            //           //           ...state.alerts.map((e) {
            //           //             return AlertItem(alert: e)
            //           //                 .paddingSymmetric(vertical: 10);
            //           //           }).toList()
            //           //         ]),
            //           //   )
            //         ],
            //       ),
            //     );
            //   },
            // ),
          );
        },
      ),
    );
  }
}
