import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/models/schedule/slot.dart';
import 'package:hypertrip/features/public/tour_detail/state.dart';
import 'package:hypertrip/generated/resource.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/theme/textStyle.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/card/card_section.dart';
import 'package:hypertrip/widgets/image/image.dart';
import 'package:hypertrip/widgets/popup/p_error_popup.dart';
import 'package:hypertrip/widgets/safe_space.dart';
import 'package:hypertrip/widgets/space/gap.dart';
import 'package:hypertrip/widgets/text/p_small_text.dart';
import 'package:hypertrip/widgets/text/p_text.dart';
import 'package:readmore/readmore.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'cubit.dart';

part 'parts/carousel.dart';
part 'parts/description.dart';
part 'parts/header.dart';
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
        listener: (context, state) {},
        builder: (context, state) {
          /// loading
          if (cubit.state is LoadingTourDetailState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          /// failed
          if (cubit.state is LoadTourDetailFailedState) {
            var errorMsg = (cubit.state as LoadTourDetailFailedState).message;
            showCupertinoModalPopup(
              context: context,
              builder: (context) => PErrorPopup(
                title: msg_error,
                content: errorMsg,
              ),
            );

            return Center(
              child: commonCachedNetworkImage(Resource.imagesTourNotFound),
            );
          }

          /// not found
          if (cubit.state is LoadTourDetailNotFoundState) {
            return Center(
              child: commonCachedNetworkImage(Resource.imagesTourNotFound),
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
                      _buildCarousel(state),
                      Gap.kSection.height,
                      Schedule(state: state)
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
