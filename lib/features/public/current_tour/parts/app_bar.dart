part of '../view.dart';

AppBar _buildAppBar(CurrentTourState state,BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    // title: const Row(
    //   children: [
    //     Text(
    //       AppConstant.APP_NAME,
    //       style: TextStyle(
    //         color: Colors.white,
    //         fontSize: 20,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //   ],
    // ),
    actions: [
      ActionButton(
        icon: Resource.iconsCloud,
        onPressed: () {
          List<LocationTour> locationTour = [];
          String tripId = '';
          // if (cubit.state is LoadCurrentTourSuccessState) {
          locationTour = (state)
              .schedule
              .map((e) => LocationTour(lat: e.latitude ?? 0.0, lng: e.longitude ?? 0.0))
              .toList();

          tripId = (state).group.trip?.id ?? '';
          // }
          if (locationTour.isEmpty) return;
          // Remove LocationTour objects with lat and lng equal to 0.0
          locationTour.removeWhere((tour) => tour.lat == 0.0 && tour.lng == 0.0);

          Navigator.of(context).pushNamed(WarningIncidentPage.routeName,
              arguments: WarningArgument(locationTour, tripId));
        },
      ),
      Gap.k16.width,
      ActionButton(
        icon: Resource.iconsInfo,
        onPressed: () {
          Navigator.pushNamed(context, TourDetailPage.routeName,
              arguments: {'tourId': (state).group.trip?.tour?.id});
        },
      ),
      Gap.k16.width,
      Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16.0, top: 8),
            child: ActionButton(
              icon: Resource.iconsBell,
              onPressed: () {
                Navigator.of(context).pushNamed(NotificationScreen.routeName);
              },
            ),
          ),
          StreamBuilder<int>(
              stream: watchCountNotify(),
              builder: (context, snapshot) {
                int value = snapshot.data ?? 0;
                if (value > 0) {
                  value = value > 99 ? 99 : value;
                  return Positioned(
                    right: 20,
                    top: 14,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.secondaryColor,
                      ),
                      child: Center(
                        child: PSmallText(
                          '$value',
                          color: white,
                          size: 10,
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              })
        ],
      ),
    ],
    title: Row(
      children: const [
        Text(
          AppConstant.APP_NAME,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
