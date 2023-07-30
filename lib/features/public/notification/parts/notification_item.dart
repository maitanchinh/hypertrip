import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hypertrip/domain/enums/activity_type.dart';
import 'package:hypertrip/domain/models/notification/firebase_message.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/utils/date_time_utils.dart';

import '../../../../widgets/text/p_small_text.dart';

class NotificationItem extends StatelessWidget {
  final FirebaseMessage item;
  final VoidCallback? callback;

  const NotificationItem({Key? key, required this.item, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: SizedBox(
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipOval(
              child: CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.secondaryColor.withOpacity(0.2),
                child: SizedBox(
                    width: 40,
                    height: 40,
                    child: item.type.name ==
                            FirebaseMessageType.AttendanceActivity.name
                        ? Transform.scale(
                          scale: 0.8,
                          child: SvgPicture.asset(
                            AppAssets.icons_attendance_svg),
                        )
                        : item.type.name == FirebaseMessageType.CheckInAcitvity.name
                            ? Transform.scale(
                              scale: 0.8,
                              child: SvgPicture.asset(
                                  AppAssets.icons_destination_svg),
                            )
                            : item.type.name ==
                                    FirebaseMessageType.TourStarted.name
                                ? Transform.scale(
                                  scale: 0.8,
                                  child: SvgPicture.asset(
                                      AppAssets.icons_finish_flag_svg),
                                )
                                : Transform.scale(
                                  scale: 0.8,
                                  child: SvgPicture.asset(
                                      AppAssets.icons_bell_color_svg),
                                )),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Html(
                    data: item.payload,
                  ),
                ),
                if (item.timestamp != null) _buildUpdatedTime()
              ],
            ),
            if (!item.isRead)
              const Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: CircleAvatar(
                    radius: 5, backgroundColor: AppColors.secondaryColor),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdatedTime() {
    return Padding(
      padding: const EdgeInsets.only(left: 7.0),
      child: PSmallText(
        DateTimeUtils.convertTimeToTimeAgo(item.timestamp),
      ),
    );
  }
}
