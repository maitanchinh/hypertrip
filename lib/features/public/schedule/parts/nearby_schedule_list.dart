part of '../view.dart';

class NearbyScheduleList extends StatefulWidget {
  final LoadNearbyScheduleSuccessState state;
  NearbyScheduleList({super.key, required this.state});

  @override
  State<NearbyScheduleList> createState() => _NearbyScheduleListState();
}

class _NearbyScheduleListState extends State<NearbyScheduleList> {
  @override
  void initState() {
    super.initState();
  }

  // @override
  // void didUpdateWidget(covariant NearbyPlaceList oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.reset) {
  //     _resetState();
  //   }
  // }

  void _resetState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

        return SafeSpace(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: widget.state.nearbySchedule!.results!.length,
            itemBuilder: (BuildContext context, int index) {
              try {
                // if (widget.state.nearbySchedule!.results![index].categories != null &&
                //     widget.state.nearbySchedule!.results![index].categories!.isNotEmpty) {
                NearbyResults results = widget.state.nearbySchedule!.results![index];
          
                return PlaceItem(
                  place: results,
                  photoIndex: 0,
                );
                // }
              } catch (e) {
                print(e.toString());
              }
              return null;
            },
          ),
        ).paddingSymmetric(vertical: 32);
      }
}
