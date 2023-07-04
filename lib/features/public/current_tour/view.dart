import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/models/schedule/slot.dart';
import 'package:hypertrip/domain/models/user/member.dart';
import 'package:hypertrip/features/public/current_tour/state.dart';
import 'package:hypertrip/features/public/page.dart';
import 'package:hypertrip/generated/resource.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/theme/theme.dart';
import 'package:hypertrip/utils/constant.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/card/card_section.dart';
import 'package:hypertrip/widgets/image/image.dart';
import 'package:hypertrip/widgets/popup/p_error_popup.dart';
import 'package:hypertrip/widgets/safe_space.dart';
import 'package:hypertrip/widgets/space/gap.dart';
import 'package:hypertrip/widgets/text/p_small_text.dart';
import 'package:hypertrip/widgets/text/p_text.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'cubit.dart';

part 'parts/custom_sliver_app_bar_delegate.dart';

part 'parts/partner.dart';

part 'parts/schedule.dart';

part 'parts/app_bar.dart';

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
      body: BlocConsumer<CurrentTourCubit, CurrentTourState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (cubit.state is LoadingCurrentTourState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (cubit.state is LoadCurrentTourFailedState) {
            var errorMsg = (cubit.state as LoadCurrentTourFailedState).message;
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

          if (cubit.state is LoadCurrentTourNotFoundState) {
            return Center(
              child: commonCachedNetworkImage(Resource.imagesTourNotFound),
            );
          }

          var state = cubit.state as LoadCurrentTourSuccessState;

          return Scaffold(
            appBar: _buildAppBar(),
            backgroundColor: AppColors.bgLightColor,
            body: RefreshIndicator(
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
            ),
          );
        },
      ),
    );
  }
}
