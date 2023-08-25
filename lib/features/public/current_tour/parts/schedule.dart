part of '../view.dart';

const kTileHeight = 50.0;

class TrackingSchedule extends StatefulWidget {
  final CurrentTourState state;

  const TrackingSchedule({super.key, required this.state});

  @override
  State<TrackingSchedule> createState() => _TrackingScheduleState();
}

class _TrackingScheduleState extends State<TrackingSchedule> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var days = widget.state.getDays();
    var scheduleByDay = widget.state.getScheduleByDay();
    List<MapEntry<int?, List<Slot>>> scheduleByDay0 = scheduleByDay.entries.toList();

    scheduleByDay0.sort((a, b) => a.key!.compareTo(b.key as num));
    if(scheduleByDay0.length > 2) {
      scheduleByDay0
        .elementAt(2)
        .value
        .map((e) => e.sequence)
        .toSet()
        .whereType<int>()
        .toList()
        .sort();
    }
    var test = widget.state.schedule.map((e) => e.sequence).toSet().whereType<int>().toList();
    test.sort();

    if(widget.state.group.trip == null) {
      return const Center(
          child: CircularProgressIndicator(),
        );
    }

    return BlocProvider(
      create: (context) => TourDetailCubit(tourId: widget.state.group.trip!.tourId),
      child: BlocBuilder<TourDetailCubit, TourDetailState>(builder: (context, state) {
        if (state is LoadingTourDetailState) {
          return const SizedBox.shrink();
        }
        if (state is LoadTourDetailSuccessState) {
          return SafeSpace(
            child: CardSection(
              child: DefaultTabController(
                length: days.length,
                initialIndex: state.tour.schedules!
                        .firstWhereOrNull(
                            (schedule) => schedule.id == widget.state.group.currentScheduleId) != null ?
                        state.tour.schedules!
                        .firstWhereOrNull(
                            (schedule) => schedule.id == widget.state.group.currentScheduleId)!.dayNo! -
                    1 : 0,
                child: Column(
                  children: [
                    // WeatherSchedules(state: widget.state),
                    // // Day tabs
                    TabBar(
                      isScrollable: true,
                      labelColor: AppColors.primaryColor,
                      unselectedLabelColor: AppColors.textGreyColor,
                      indicatorColor: AppColors.primaryColor,
                      tabs: [
                        for (var i = 0; i < days.length; i++)
                          Tab(
                            text: "Day ${i + 1}",
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 300,
                      child: TabBarView(
                        children: [
                          ...days.map(
                            (e) {
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: scheduleByDay[e]?.length ?? 0,
                                itemBuilder: (context, index) {
                                  if (state is LoadingTourDetailState) {
                                    return TimelineTile(
                                      indicatorStyle: const IndicatorStyle(
                                        width: 15,
                                        color: AppColors.textGreyColor,
                                        padding: EdgeInsets.all(6),
                                      ),
                                      beforeLineStyle: const LineStyle(
                                          color: AppColors.textGreyColor, thickness: 1),
                                      isFirst: index == 0,
                                      isLast: index == scheduleByDay[e]!.length - 1,
                                      endChild:
                                          buildSlotTile(Map.fromEntries(scheduleByDay0), e, index),
                                    );
                                  }
                                  var sortedSchedule = scheduleByDay[e]?.toSet().toList();
                                  sortedSchedule!
                                      .sort((a, b) => a.sequence!.compareTo(b.sequence as num));
                                  return TimelineTile(
                                    indicatorStyle: IndicatorStyle(
                                      width: 15,
                                      color: state.tour.schedules!
                                                  .firstWhereOrNull((schedule) =>
                                                      schedule.id ==
                                                      widget.state.group.currentScheduleId) != null ?
                                                  (state.tour.schedules!
                                                  .firstWhereOrNull((schedule) =>
                                                      schedule.id ==
                                                      widget.state.group.currentScheduleId)!.sequence! >=
                                              sortedSchedule[index].sequence!
                                          ? AppColors.primaryColor
                                          : AppColors.textGreyColor) : AppColors.textGreyColor,
                                      padding: const EdgeInsets.all(6),
                                    ),
                                    beforeLineStyle: LineStyle(
                                        color: state.tour.schedules!
                                                  .firstWhereOrNull((schedule) =>
                                                      schedule.id ==
                                                      widget.state.group.currentScheduleId) != null ?
                                                  (state.tour.schedules!
                                                  .firstWhereOrNull((schedule) =>
                                                      schedule.id ==
                                                      widget.state.group.currentScheduleId)!.sequence! >=
                                              sortedSchedule[index].sequence!
                                          ? AppColors.primaryColor
                                          : AppColors.textGreyColor) : AppColors.textGreyColor,
                                        thickness: 1),
                                    isFirst: index == 0,
                                    isLast: index == scheduleByDay[e]!.length - 1,
                                    endChild: buildSlotTile(scheduleByDay, e, index),
                                  );
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }

  Container buildSlotTile(Map<int?, List<Slot>> scheduleByDay, int e, int index) {
    var sortedSchedule = scheduleByDay[e]?.toSet().toList();
    sortedSchedule!.sort((a, b) => a.sequence!.compareTo(b.sequence as num));
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: PSmallText(
        sortedSchedule[index].description ?? "",
        color: AppColors.textColor,
      ),
    );
  }
}
