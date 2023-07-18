import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hypertrip/domain/models/notification/firebase_message.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/utils/date_time_utils.dart';

class NotificationItem extends StatelessWidget {
  final FirebaseMessage item;
  final VoidCallback? callback;

  const NotificationItem({Key? key, required this.item, this.callback}) : super(key: key);

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
                    width: 60,
                    height: 60,
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.fitHeight,
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
                child: CircleAvatar(radius: 5, backgroundColor: Colors.blueAccent),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdatedTime() {
    return Padding(
      padding: const EdgeInsets.only(left: 7.0),
      child: Text(
        DateTimeUtils.convertTimeToTimeAgo(item.timestamp),
        style: AppStyle.fontOpenSanLight.copyWith(color: AppColors.textGreyColor, fontSize: 16),
      ),
    );
  }
}
