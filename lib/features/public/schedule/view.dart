import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:chatview/chatview.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes/google_maps_routes.dart';
import 'package:hypertrip/domain/repositories/firestore_repository.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/features/root/cubit.dart';
import 'package:hypertrip/features/root/state.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:intl/intl.dart' as intl;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/models/nearby/nearby_place.dart';
import '../../../domain/models/schedule/slot.dart';
import '../../../theme/color.dart';
import '../../../widgets/button/action_button.dart';
import '../../../widgets/image/image.dart';
import '../../../widgets/safe_space.dart';
import '../../../widgets/space/gap.dart';
import '../../../widgets/text/p_small_text.dart';
import '../../../widgets/text/p_text.dart';
import '../permission/cubit.dart';
import '../permission/state.dart';
import 'cubit.dart';
import 'state.dart';

part './parts/location_tracking_component.dart';
part './parts/nearby_place.dart';
part './parts/place.dart';
part './parts/detail_screen.dart';
part './parts/detail_component.dart';
part './parts/carousel.dart';
part './parts/place_photo.dart';
part './parts/nearby_place_suggestion.dart';
part './parts/nearby_schedule_list.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = '/schedule';

  const ScheduleScreen({super.key});
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int selectCategoryIndex = 0;
  List<Slot> slots = [];
  bool locationWidth = true;

  @override
  void initState() {
    // final cubit = BlocProvider.of<CurrentTourCubit>(context);
    // slots = (cubit.state as LoadCurrentTourSuccessState)
    //     .schedule
    //     .where((tour) => tour.latitude != null && tour.longitude != null)
    //     .toList()
    //   ..sort((a, b) => a.sequence!.compareTo(b.sequence as num));
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentTourCubit>(
      create: (context) => CurrentTourCubit(),
      child: BlocBuilder<CurrentLocationCubit, CurrentLocationState>(
        builder: (context, state) => _buildPage(context, state as LoadCurrentLocationSuccessState),
      ),
    );
  }

  Widget _buildPage(BuildContext context, LoadCurrentLocationSuccessState locationState) {
    final cubit = BlocProvider.of<CurrentLocationCubit>(context);

    return BlocBuilder<CurrentTourCubit, CurrentTourState>(
        builder: (context, state) {
          if (state is LoadCurrentTourNotFoundState) {
            return Scaffold(
            extendBodyBehindAppBar: true,
            body: BlocProvider(
              create: (BuildContext context) => NearbyPlaceCubit(locationState.location, ''),
              child: SizedBox(
                height: context.height(),
                child: Image.asset(AppAssets.tour_not_found_png),
              ),
            ));
          }
      if (state is LoadCurrentTourSuccessState) {
        return Scaffold(
            extendBodyBehindAppBar: true,
            body: BlocProvider(
              create: (BuildContext context) => NearbyPlaceCubit(locationState.location, ''),
              child: SizedBox(
                height: context.height(),
                child: LocationTracking(
                  slots: state.schedule
                      .where((element) =>
                          element.latitude != null &&
                          element.longitude != null)
                      .toList()
                    ..sort((a, b) =>
                        a.sequence!.compareTo(b.sequence as num)),
                ),
              ),
            ));
      }
      return const SizedBox.shrink();
    });
  }
}
