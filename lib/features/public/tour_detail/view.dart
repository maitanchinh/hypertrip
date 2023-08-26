import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hypertrip/domain/models/schedule/slot.dart';
import 'package:hypertrip/domain/models/tour/carousel.dart';
import 'package:hypertrip/domain/models/tour/tour_detail.dart';
import 'package:hypertrip/features/public/tour_detail/state.dart';
import 'package:hypertrip/generated/resource.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/theme/text_style.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/card/card_section.dart';
import 'package:hypertrip/widgets/popup/p_error_popup.dart';
import 'package:hypertrip/widgets/safe_space.dart';
import 'package:hypertrip/widgets/space/gap.dart';
import 'package:hypertrip/widgets/text/p_small_text.dart';
import 'package:hypertrip/widgets/text/p_text.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:readmore/readmore.dart' as Readmore;
import 'package:timeline_tile/timeline_tile.dart';

import '../../../utils/app_assets.dart';
import '../../../widgets/button/action_button.dart';
import 'cubit.dart';

part 'parts/carousel.dart';
part 'parts/description.dart';
part 'parts/header.dart';
part 'parts/photo.dart';
part 'parts/schedule.dart';

class TourDetailPage extends StatelessWidget {
  static const routeName = '/tour-detail';
  final String? tourId;

  const TourDetailPage({super.key, required this.tourId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TourDetailCubit(tourId: tourId),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<TourDetailCubit>(context);

    return Scaffold(
      body: BlocConsumer<TourDetailCubit, TourDetailState>(
        listener: (context, state) {
          if (cubit.state is LoadTourDetailFailedState) {
            var errorMsg = (cubit.state as LoadTourDetailFailedState).message;
            showErrorPopup(context, content: errorMsg);
          }
        },
        builder: (context, state) {
          SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.white, // Set your desired color here
            statusBarIconBrightness:
                Brightness.dark, // Set the brightness of the status bar icons
          ));

          /// loading
          if (cubit.state is LoadingTourDetailState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          /// failed
          if (cubit.state is LoadTourDetailFailedState) {
            return Center(
              child: Image.asset(Resource.imagesTourNotFound),
            );
          }

          /// not found
          if (cubit.state is LoadTourDetailNotFoundState) {
            return Center(
              child: Image.asset(Resource.imagesTourNotFound),
            );
          }

          /// success
          var state = cubit.state as LoadTourDetailSuccessState;

          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: SafeSpace(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(state, context),
                      Gap.kSection.height,
                      const PText(label_description),
                      Gap.k8.height,
                      _buildDescription(state),
                      Gap.kSection.height,
                      _buildCarousel(state.tour),
                      Gap.kSection.height,
                      state.tour.schedules!.isNotEmpty ? Column(
                        children: [
                          const PText(label_schedule),
                          Gap.k8.height,
                          Schedule(state: state),
                        ],
                      ): const SizedBox.shrink()
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
