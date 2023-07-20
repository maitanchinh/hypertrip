part of '../view.dart';

const kTileHeight = 50.0;

class TrackingSchedule extends StatefulWidget {
  final LoadCurrentTourSuccessState state;

  const TrackingSchedule({super.key, required this.state});

  @override
  State<TrackingSchedule> createState() => _TrackingScheduleState();
}

class _TrackingScheduleState extends State<TrackingSchedule>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var schedule = widget.state.schedule;
    var days = widget.state.getDays();
    var scheduleByDay = widget.state.getScheduleByDay();

    return SafeSpace(
      child: CardSection(
        child: DefaultTabController(
          length: days.length,
          child: Column(
            children: [
              // Day tabs
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
                height: 500,
                child: TabBarView(
                  children: [
                    ...days.map(
                      (e) => ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: scheduleByDay[e]?.length ?? 0,
                        itemBuilder: (context, index) => TimelineTile(
                          indicatorStyle: const IndicatorStyle(
                            width: 15,
                            color: AppColors.primaryColor,
                            padding: EdgeInsets.all(6),
                          ),
                          beforeLineStyle: const LineStyle(
                              color: AppColors.primaryColor, thickness: 1),
                          isFirst: index == 0,
                          isLast: index == scheduleByDay[e]!.length - 1,
                          endChild: buildSlotTile(scheduleByDay, e, index),
                        ),
                      ),
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

  Container buildSlotTile(
      Map<int?, List<Slot>> scheduleByDay, int e, int index) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: PSmallText(
        scheduleByDay[e]?[index].description ?? "",
        color: AppColors.textColor,
      ),
    );
  }
}
