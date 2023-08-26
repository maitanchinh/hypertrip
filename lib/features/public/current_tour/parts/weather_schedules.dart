part of '../view.dart';

class WeatherSchedules extends StatefulWidget {
  final CurrentTourState state;

  const WeatherSchedules({Key? key, required this.state}) : super(key: key);

  @override
  State<WeatherSchedules> createState() => _WeatherSchedulesState();
}

class _WeatherSchedulesState extends State<WeatherSchedules> {
  bool isExpanded = true;
  final PageController _pageController = PageController(initialPage: 0);
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeSpace(
      child: CardSection(
        child: Column(
          children: [
            SizedBox(
              height: 244,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.state.dataWeatherTour.length,
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
      
                  final currentTourCubit =
                      BlocProvider.of<CurrentTourCubit>(context);
                  currentTourCubit.fetchDataWeather(value);
                },
                itemBuilder: (context, index) {
                  final weatherResponse = widget.state.dataWeatherTour[index];
                  return Column(
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const PText(
                      //       "Today",
                      //       size: 16,
                      //     ),
                      //     IconButton(
                      //       onPressed: () {
                      //         setState(() {
                      //           isExpanded = !isExpanded;
                      //         });
                      //       },
                      //       icon: SvgPicture.asset(
                      //         !isExpanded
                      //             ? AppAssets.icons_angle_up_svg
                      //             : AppAssets.icons_angle_down_svg,
                      //         height: 16,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Address(
                                address: weatherResponse?.location.name ?? ''),
                            TimeAddress(
                                time: weatherResponse?.location.localtime ?? ''),
                          ],
                        ),
                      ),
                      Gap.k16.height,
                      Termp(
                          temp: weatherResponse?.current.tempC.toInt() ?? 0,
                          conditionText:
                              weatherResponse?.current.condition?.text ?? ''),
                              Gap.k16.height,
                      ItemWind(
                        hPa: weatherResponse?.current.pressureMb.toInt() ?? 0,
                        humidity: weatherResponse?.current.humidity ?? 0,
                        windKph: weatherResponse?.current.windKph ?? 0.0,
                      ),
                      Gap.k16.height,
                      WeatherDay(
                        weatherForecastDay: widget
                            .state.dataWeatherTour[index]!.forecast.forecastDay,
                        color: Colors.white,
                        callback: () {
                          Navigator.of(context).pushNamed(
                            WeatherDetailPage.routeName,
                            arguments: widget.state.dataWeatherTour[index],
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            if (widget.state.dataWeatherTour.isNotEmpty && isExpanded)
              SmoothPageIndicator(
                controller: _pageController, // PageController
                count: widget.state.dataWeatherTour.length,
                effect: const WormEffect(
                    activeDotColor: AppColors.primaryColor,
                    dotHeight: 6,
                    dotWidth: 6), // your preferred effect
              ),
          ],
        ),
      ),
    );
  }
}
