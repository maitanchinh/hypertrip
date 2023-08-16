part of '../view.dart';

class WeatherSchedules extends StatefulWidget {
  final LoadCurrentTourSuccessState state;

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
    return AnimatedContainer(
      height: widget.state.dataWeatherTour.isNotEmpty
          ? isExpanded
              ? 461
              : 230
          : 0,
      duration: const Duration(milliseconds: 300),
      decoration: const BoxDecoration(
          color: AppColors.bgLightColor, borderRadius: BorderRadius.all(Radius.circular(16))),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          10.height,
          WeatherDay(
            weatherForecastDay: widget.state.dataWeatherTour[index]!.forecast.forecastDay,
            color: Colors.white,
            callback: () {
              Navigator.of(context).pushNamed(
                WeatherDetailPage.routeName,
                arguments: widget.state.dataWeatherTour[index],
              );
            },
          ),
          Flexible(
            child: SizedBox(
              height: isExpanded ? 250 : 48,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.state.dataWeatherTour.length,
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });

                  final currentTourCubit = BlocProvider.of<CurrentTourCubit>(context);
                  currentTourCubit.fetchDataWeather(value);
                },
                itemBuilder: (context, index) {
                  final weatherResponse = widget.state.dataWeatherTour[index];
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const PText(
                            "Today",
                            size: 16,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            icon: Icon(
                              isExpanded ? Icons.remove_circle_outline : Icons.add_circle_outline,
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Address(address: weatherResponse?.location.name ?? ''),
                              TimeAddress(time: weatherResponse?.location.localtime ?? ''),
                            ],
                          ),
                        ),
                      ),
                      Flexible(child: 10.height),
                      Flexible(flex: 6,
                        child: Termp(
                            temp: weatherResponse?.current.tempC.toInt() ?? 0,
                            conditionText: weatherResponse?.current.condition?.text ?? ''),
                      ),
                      Flexible(child: 22.height),
                      Flexible(
                        flex: 1,
                        child: ItemWind(
                          hPa: weatherResponse?.current.pressureMb.toInt() ?? 0,
                          humidity: weatherResponse?.current.humidity ?? 0,
                          windKph: weatherResponse?.current.windKph ?? 0.0,
                        ),
                      ),
                      Flexible(child: 25.height),
                    ],
                  );
                },
              ),
            ),
          ),
          if (widget.state.dataWeatherTour.isNotEmpty && isExpanded)
          SmoothPageIndicator(
            controller: _pageController, // PageController
            count: widget.state.dataWeatherTour.length,
            effect: const WormEffect(activeDotColor: AppColors.primaryColor,dotHeight: 12,dotWidth: 12), // your preferred effect
          )
        ],
      ),
    );
  }
}
