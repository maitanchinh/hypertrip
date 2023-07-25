part of '../view.dart';

AppBar _buildAppBar(BuildContext context) {
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
          final cubit = BlocProvider.of<CurrentTourCubit>(context);
          List<LocationTour> locationTour = [];
          String tripId = '';
          if (cubit.state is LoadCurrentTourSuccessState) {
            locationTour = (cubit.state as LoadCurrentTourSuccessState)
                .schedule
                .map((e) => LocationTour(lat: e.latitude ?? 0.0, lng: e.longitude ?? 0.0))
                .toList();

            tripId = (cubit.state as LoadCurrentTourSuccessState).group.trip?.id ?? '';
          }
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
        onPressed: () {},
      ),
      Gap.k16.width,
      Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
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
                    right: 5,
                    top: 5,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Center(
                        child: Text('$value',
                            style: AppStyle.fontOpenSanRegular
                                .copyWith(fontSize: 14, color: AppColors.textColor)),
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
