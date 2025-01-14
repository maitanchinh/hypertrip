import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hypertrip/domain/models/notification/firebase_message.dart';
import 'package:hypertrip/domain/repositories/notification_repo.dart';
import 'package:hypertrip/features/public/current_tour/cubit.dart';
import 'package:hypertrip/features/public/notification/notification_bloc.dart';
import 'package:hypertrip/features/public/notification/parts/notification_item.dart';
import 'package:hypertrip/features/public/warning_incident/interactor/warning_incident_bloc.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';
import 'package:hypertrip/utils/date_time_utils.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/utils/page_command.dart';
import 'package:hypertrip/widgets/app_bar.dart';
import 'package:hypertrip/widgets/app_widget.dart';
import 'package:hypertrip/widgets/no_data_widget.dart';

import '../../../widgets/text/p_text.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = '/notification';

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          NotificationBloc(GetIt.I.get<NotificationRepo>())
            ..add(const FetchNotificationList()),
      child: BlocListener<NotificationBloc, NotificationState>(
        listener: (BuildContext context, state) {
          if (state.pageCommand is PageCommandNavigatorPage) {
            changePage(state.pageCommand as PageCommandNavigatorPage, context);
          }

          context.read<NotificationBloc>().add(const OnClearPageCommand());
        },
        child: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
          return Scaffold(
            appBar: MainAppBar(
              title: notificationTitle,
              implyLeading: true,
              actions: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SizedBox(
                      width: 80,
                      child: TextButton(
                        child: const PText(
                          markRead,
                          color: AppColors.primaryColor,
                          size: 16,
                        ),
                        onPressed: () => context
                            .read<NotificationBloc>()
                            .add(const NotifyReadAll()),
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: LoadableWidget(
              status: state.status,
              errorText: state.error,
              failureOnPress: () => context
                  .read<NotificationBloc>()
                  .add(const FetchNotificationList()),
              child: state.notifications.isEmpty
                  ? NoDataWidget(onPressed: () {}, content: noData)
                  : GroupedListView<FirebaseMessage, String>(
                      elements: state.notifications,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                      groupBy: (message) => DateTimeUtils.convertDateTimeString(
                          message.timestamp),
                      groupComparator: (group1, group2) =>
                          group2.compareTo(group1),
                      groupSeparatorBuilder: (String groupValue) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PText(
                          groupValue,
                          size: 16,
                        ),
                      ),
                      itemComparator: (item1, item2) =>
                          item2.timestamp!.compareTo(item1.timestamp!),
                      itemBuilder: (context, message) {
                        return NotificationItem(
                          item: message,
                          callback: () {
                            context
                                .read<NotificationBloc>()
                                .add(ItemNotificationClick(item: message));
                          },
                        );
                      },
                    ),
            ),
          );
        }),
      ),
    );
  }

  void changePage(PageCommandNavigatorPage page, BuildContext context) {
    Navigator.of(context).pushNamed(page.page!, arguments: page.argument);
  }
}
