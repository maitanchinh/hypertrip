import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hypertrip/features/public/page.dart';
import 'package:hypertrip/features/traveler/history/part/cubit.dart';
import 'package:hypertrip/features/traveler/history/part/state.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/widgets/app_bar.dart';
import 'package:hypertrip/widgets/space/gap.dart';
import 'package:hypertrip/widgets/text/p_small_text.dart';
import 'package:hypertrip/widgets/text/p_text.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class TravelerHistory extends StatefulWidget {
  final String travelerId;
  const TravelerHistory({super.key, required this.travelerId});

  @override
  State<TravelerHistory> createState() => _TravelerHistoryState();
}

class _TravelerHistoryState extends State<TravelerHistory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TravelerHistoryCubit(widget.travelerId),
      child: BlocBuilder<TravelerHistoryCubit, TravelerHistoryState>(
          builder: (context, state) {
        if (state is LoadingTravelerHistoryState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoadTravelerHistorySuccessState) {
          return Scaffold(
            appBar: const MainAppBar(
              implyLeading: true,
              title: 'History',
            ),
            body: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16)),
                          height: 100,
                          width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: FadeInImage.assetNetwork(
                              placeholder: AppAssets.placeholder_png,
                              image:
                                  state.tours[index].trip!.tour!.thumbnailUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Gap.k16.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: PText(
                                state.tours[index].trip!.tour!.title,
                                color: AppColors.textColor,
                                size: 16,
                              ),
                            ),
                            Gap.k8.height,
                            Row(
                              children: [
                                SvgPicture.asset(
                                  AppAssets.icons_users_svg,
                                  width: 16,
                                  color: AppColors.greyColor,
                                ),
                                Gap.k8.width,
                                PSmallText(
                                    color: AppColors.greyColor,
                                    'Group ${state.tours[index].groupNo}'),
                              ],
                            ),
                            Gap.k8.height,
                            Row(
                              children: [
                                SvgPicture.asset(
                                  AppAssets.icons_calendar_svg,
                                  width: 16,
                                  color: AppColors.greyColor,
                                ),
                                Gap.k8.width,
                                PSmallText(
                                    color: AppColors.greyColor,
                                    '${DateFormat('dd-MM-yyyy').format(DateTime.parse(state.tours[index].trip!.startTime!))} - ${DateFormat('dd-MM-yyyy').format(DateTime.parse(state.tours[index].trip!.endTime!))}'),
                              ],
                            ),
                            Gap.k8.height,
                            Row(
                              children: [
                                SvgPicture.asset(
                                  AppAssets.icons_clock_svg,
                                  width: 16,
                                  color: AppColors.greyColor,
                                ),
                                Gap.k8.width,
                                PSmallText(
                                    color: AppColors.greyColor,
                                    state.tours[index].trip!.tour!.duration),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ).onTap(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TourDetailPage(
                                tourId: state.tours[index].trip!.tourId)));
                  });
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: state.tours.length),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
