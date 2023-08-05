part of '../view.dart';

class NearbyPlaceList extends StatefulWidget {
  final LoadNearbyPlaceSuccessState state;
  NearbyPlaceList({super.key, required this.state});

  @override
  State<NearbyPlaceList> createState() => _NearbyPlaceListState();
}

class _NearbyPlaceListState extends State<NearbyPlaceList> {
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
            itemCount: widget.state.nearbyPlace!.results!.length,
            itemBuilder: (BuildContext context, int index) {
              try {
                // if (widget.state.nearbyPlace!.results![index].categories != null &&
                //     widget.state.nearbyPlace!.results![index].categories!.isNotEmpty) {
                NearbyResults results = widget.state.nearbyPlace!.results![index];
          
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
