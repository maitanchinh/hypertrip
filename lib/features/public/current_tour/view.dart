import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes/google_maps_routes.dart';
import 'package:hypertrip/domain/models/schedule/slot.dart';
import 'package:hypertrip/domain/models/user/member.dart';
import 'package:hypertrip/features/public/current_tour/state.dart';
import 'package:hypertrip/features/public/notification/notifcation_screen.dart';
import 'package:hypertrip/features/public/page.dart';
import 'package:hypertrip/generated/resource.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/theme/theme.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/utils/constant.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/card/card_section.dart';
import 'package:hypertrip/widgets/image/image.dart';
import 'package:hypertrip/widgets/popup/p_error_popup.dart';
import 'package:hypertrip/widgets/safe_space.dart';
import 'package:hypertrip/widgets/space/gap.dart';
import 'package:hypertrip/widgets/text/p_small_text.dart';
import 'package:hypertrip/widgets/text/p_text.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'cubit.dart';

part 'parts/app_bar.dart';
part 'parts/custom_sliver_app_bar_delegate.dart';
part 'parts/partner.dart';
part 'parts/schedule.dart';

part 'parts/map_screen.dart';

part 'parts/location_tracking_component.dart';

class CurrentTourPage extends StatelessWidget {
  static const routeName = '/current-tour';

  const CurrentTourPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CurrentTourCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<CurrentTourCubit>(context);
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: AppColors.bgLightColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MapScreen()),
          );
        },
        label: PText(
          'Map',
          color: white,
        ),
        icon: SvgPicture.asset(
          Resource.iconsMap,
          width: 16,
          color: white,
        ),
      ),
      body: BlocConsumer<CurrentTourCubit, CurrentTourState>(
        listener: (context, state) {
          if (cubit.state is LoadCurrentTourFailedState) {
            var errorMsg = (cubit.state as LoadCurrentTourFailedState).message;
            showErrorPopup(context, content: errorMsg);
          }
        },
        builder: (context, state) {
          if (cubit.state is LoadingCurrentTourState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (cubit.state is LoadCurrentTourFailedState) {
            return Center(
              child: commonCachedNetworkImage(Resource.imagesTourNotFound),
            );
          }

          if (cubit.state is LoadCurrentTourNotFoundState) {
            return Center(
              child: commonCachedNetworkImage(Resource.imagesTourNotFound),
            );
          }

          var state = cubit.state as LoadCurrentTourSuccessState;

          return RefreshIndicator(
            onRefresh: () async {
              cubit.refresh();
            },
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: CustomSliverAppBarDelegate(
                    state: state,
                    expandedHeight: 200,
                  ),
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Partner(state: state),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: TrackingSchedule(state: state),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
