part of '../view.dart';

class NearbyPlaceList extends StatefulWidget {
  final String query;
  NearbyPlaceList({super.key, required this.query});

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
    return BlocBuilder<NearbyPlaceCubit, NearbyPlaceState>(
        builder: (context, state) {
      if (state is LoadingNearbyPlaceState) {
        return const CircularProgressIndicator();
      }
      if (state is NoResultsNearbyPlaceState) {
        return Center(
          child: Column(
            children: [
              32.height,
              Image.asset(
                AppAssets.not_found_png,
                width: 200,
              ),
              const PText(
                "Couldn't find any places around here",
              ),
            ],
          ),
        );
      }
      if (state is LoadNearbyPlaceSuccessState) {
        return SafeSpace(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: state.nearbyPlace!.results!.length,
            itemBuilder: (BuildContext context, int index) {
              try {
                // if (state.nearbyPlace!.results![index].categories != null &&
                //     state.nearbyPlace!.results![index].categories!.isNotEmpty) {
                NearbyResults results = state.nearbyPlace!.results![index];
          
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
      return const SizedBox.shrink();
    });
  }
}
