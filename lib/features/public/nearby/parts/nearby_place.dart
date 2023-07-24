part of '../view.dart';

class NearbyPlace extends StatefulWidget {
  final String query;
  final bool reset;
  NearbyPlace({super.key, required this.query, required this.reset});

  @override
  State<NearbyPlace> createState() => _NearbyPlaceState();
}

class _NearbyPlaceState extends State<NearbyPlace> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NearbyPlace oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.reset) {
      _resetState();
    }
  }

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
                Resource.imagesNotFound,
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
        return Expanded(
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

                return Place(
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
        );
      }
      return const SizedBox.shrink();
    });
  }
}
