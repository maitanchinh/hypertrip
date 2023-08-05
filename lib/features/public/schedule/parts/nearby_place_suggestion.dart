part of '../view.dart';

class NearbyPlaceSuggestion extends StatefulWidget {
  final String query;
  final Position location;
  NearbyPlaceSuggestion({super.key, required this.query, required this.location});

  @override
  State<NearbyPlaceSuggestion> createState() => _NearbyPlaceSuggestionState();
}

class _NearbyPlaceSuggestionState extends State<NearbyPlaceSuggestion> {
  @override
  void initState() {
    super.initState();
  }

  // @override
  // void didUpdateWidget(covariant NearbyPlaceSuggestion oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.isReset) {
  //     _resetState();
  //   }
  // }

  // void _resetState() {
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => NearbyPlaceSuggestionCubit(widget.location) ,
      child: BlocBuilder<NearbyPlaceSuggestionCubit, NearbyPlaceSuggestionState>(
          builder: (context, state) {
        if (state is LoadingNearbyPlaceSuggestionState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is NoResultsNearbyPlaceSuggestionState) {
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
        if (state is LoadNearbyPlaceSuggestionSuccessState) {
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: state.nearbyPlace!.results!.where((element) => element.rating != null && element.rating! > 8).length,
            itemBuilder: (BuildContext context, int index) {
              try {
                // if (state.nearbyPlace!.results![index].categories != null &&
                //     state.nearbyPlace!.results![index].categories!.isNotEmpty) {
                NearbyResults results = state.nearbyPlace!.results!.where((element) => element.rating != null && element.rating! > 8).toList()[index];
          
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
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
