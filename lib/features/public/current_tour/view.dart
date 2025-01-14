import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes/google_maps_routes.dart';
import 'package:hypertrip/domain/enums/user_role.dart';
import 'package:hypertrip/domain/models/incidents/warning_argument.dart';
import 'package:hypertrip/domain/models/schedule/slot.dart';
import 'package:hypertrip/domain/models/user/member.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/extensions/enum.dart';
import 'package:hypertrip/features/public/current_tour/state.dart';
import 'package:hypertrip/features/public/notification/notifcation_screen.dart';
import 'package:hypertrip/features/public/page.dart';
import 'package:hypertrip/features/public/permission/cubit.dart';
import 'package:hypertrip/features/public/permission/state.dart';
import 'package:hypertrip/features/public/tour_detail/cubit.dart';
import 'package:hypertrip/features/public/tour_detail/state.dart';
import 'package:hypertrip/features/public/warning_incident/components/address.dart';
import 'package:hypertrip/features/public/warning_incident/components/item_wind.dart';
import 'package:hypertrip/features/public/warning_incident/components/termp.dart';
import 'package:hypertrip/features/public/warning_incident/components/time_address.dart';
import 'package:hypertrip/features/public/warning_incident/components/weather_day.dart';
import 'package:hypertrip/features/public/warning_incident/interactor/warning_incident_bloc.dart';
import 'package:hypertrip/features/public/weather_detail/weather_detail_page.dart';
import 'package:hypertrip/generated/resource.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/theme/theme.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/utils/app_shared.dart';
import 'package:hypertrip/utils/constant.dart';
import 'package:hypertrip/utils/date_time_utils.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/app_widget.dart';
import 'package:hypertrip/widgets/button/action_button.dart';
import 'package:hypertrip/widgets/card/card_section.dart';
import 'package:hypertrip/widgets/image/image.dart';
import 'package:hypertrip/widgets/popup/p_error_popup.dart';
import 'package:hypertrip/widgets/safe_space.dart';
import 'package:hypertrip/widgets/space/gap.dart';
import 'package:hypertrip/widgets/text/p_small_text.dart';
import 'package:hypertrip/widgets/text/p_text.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:hypertrip/features/traveler/page.dart' as TravelerPage;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'cubit.dart';

part 'parts/app_bar.dart';

part 'parts/custom_sliver_app_bar_delegate.dart';

part 'parts/partner.dart';

part 'parts/schedule.dart';

part 'parts/weather_schedules.dart';

part 'parts/map_screen.dart';

part 'parts/location_tracking_component.dart';

class CurrentTourPage extends StatelessWidget {
  static const routeName = '/current-tour';

  const CurrentTourPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) => _buildPage(context));
  }

  Widget _buildPage(BuildContext context) {
    final cubit = GetIt.I.get<CurrentTourCubit>();
    return BlocProvider(
      create: (context) => cubit..refresh(),
      child: BlocBuilder<CurrentTourCubit, CurrentTourState>(
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: _buildAppBar(state, context),
            backgroundColor: AppColors.bgLightColor,
            body: LoadableWidget(
              status: state.status,
              errorText: state.message,
              failureOnPress: () {},
              childNoData: Center(
                child: Image.asset(Resource.imagesTourNotFound),
              ),
              child: RefreshIndicator(
                onRefresh: () async {
                  cubit.refresh();
                },
                child: CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      delegate: CustomSliverAppBarDelegate(
                        state: state,
                        expandedHeight: 250,
                      ),
                      pinned: true,
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Gap.kSection.height,
                          Container(
                            height: 45,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(8))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                PText(
                                    "Start Date: ${DateTimeUtils.convertDateTimeString(state.group.trip?.startTime, format: 'MM-dd')} - "),
                                PText(
                                    "End Date: ${DateTimeUtils.convertDateTimeString(state.group.trip?.endTime, format: 'MM-dd')}"),
                              ],
                            ).paddingSymmetric(horizontal: 16),
                          ),
                          Gap.k16.height,
                          Partner(state: state),
                          Gap.k16.height,
                          // TrackingSchedule(state: state)
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      // child: TrackingSchedule(state: state),
                      child: BlocProvider<TourDetailCubit>(
                        create: (context) => TourDetailCubit(tourId: state.group.trip!.tourId),
                        child: Builder(builder: (context) => TrackingSchedule(state: state)),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Gap.k16.height,
                          WeatherSchedules(state: state),
                          // TrackingSchedule(state: state)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: UserRepo.profile?.role != 'Traveler' && state.group.id != null
                ? InkWell(
                    onTap: () {},
                    child: Container(
                      width: 80,
                      height: 56,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: IconButton(
                        onPressed: () => showDialogEndTour(context, cubit, state.group.id ?? ''),
                        icon: const Column(
                          children: [
                            Icon(Icons.pin_end),
                            Text("End tour"),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Future<void> showDialogEndTour(BuildContext context, CurrentTourCubit cubit, String id) async {
    await showCupertinoDialog(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: const Text('End Tour'),
        content: const Text('Do you want to end current tour?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("No"),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(dialogContext).pop();
              cubit.onClickEndTour(id);
            },
            child: const Text("Yes"),
          )
        ],
      ),
    );
  }
}
