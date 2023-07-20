part of '../view.dart';

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.primaryColor,
    title: const Row(
      children: [
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
    actions: [
      IconButton(
        onPressed: () {
          final cubit = BlocProvider.of<CurrentTourCubit>(context);
          List<LocationTour> locationTour = [];
          if(cubit.state is LoadCurrentTourSuccessState) {
            locationTour = (cubit.state as LoadCurrentTourSuccessState).schedule
                .map((e) => LocationTour(lat: e.latitude ?? 0.0, lng: e.longitude ?? 0.0)).toList();
          }
          if(locationTour.isEmpty)return;
          Navigator.of(context).pushNamed(WarningIncidentPage.routeName, arguments: locationTour);
        },
        icon: SvgPicture.asset(AppAssets.icons_ic_cloud_solid_svg, color: Colors.white,),
      ),
      Stack(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(NotificationScreen.routeName);
            },
            icon: const Icon(Icons.notifications, color: Colors.white),
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
                            style: AppStyle.fontOpenSanRegular.copyWith(
                                fontSize: 14, color: AppColors.textColor)),
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
  );
}
