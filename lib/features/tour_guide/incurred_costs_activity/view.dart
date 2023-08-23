import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/extensions/datetime.dart';
import 'package:hypertrip/features/tour_guide/incurred_costs_activity/cubit.dart';
import 'package:hypertrip/features/tour_guide/incurred_costs_activity/part/remove_button.dart';
import 'package:hypertrip/features/tour_guide/incurred_costs_activity/state.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/currency_formatter.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/utils/picture.dart';
import 'package:hypertrip/widgets/base_page.dart';
import 'package:hypertrip/widgets/image/vertical/image_vertical_list.dart';
import 'package:hypertrip/widgets/safe_space.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

part 'part/amount_input.dart';
part 'part/app_bar.dart';
part 'part/date_input.dart';
part 'part/image_collection.dart';
part 'part/label.dart';
part 'part/note.dart';
part 'part/save_button.dart';
part 'part/time_input.dart';

class IncurredCostsActivity extends StatefulWidget {
  static const routeName = '/tour_guide/incurred_costs_activity';
  final String? id;
  const IncurredCostsActivity({super.key, this.id});

  @override
  State<IncurredCostsActivity> createState() => _IncurredCostsActivityState();
}

class _IncurredCostsActivityState extends State<IncurredCostsActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: AppColors.bgLightColor,
      body: BasePage(
        child: _buildBody(context),
      ),
    );
  }

  @override
  void initState() {
    final cubit = BlocProvider.of<IncurredCostsActivityCubit>(context);
    cubit.init();

    if (widget.id != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        final cubit = BlocProvider.of<IncurredCostsActivityCubit>(context);
        cubit.load(widget.id!);
      });
    }

    super.initState();
  }

  Widget _buildBody(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          height: size.height / 2,
          color: AppColors.primaryColor,
        ),
        Positioned(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(top: 32),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      color: AppColors.bgLightColor,
                    ),
                    child: SafeArea(
                      child: SafeSpace(
                        child: Column(
                          children: [
                            BlocBuilder<IncurredCostsActivityCubit,
                                    IncurredCostsActivityState>(
                                builder: (context, state) {
                              if (state.isLoading) {
                                return const SizedBox(
                                  height: 60,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              } else {
                                return Container();
                              }
                            }),
                            const AmountInput(),
                            32.height,
                            const Label(label_incurred_costs_date_time),
                            const TimeInput(),
                            16.height,
                            const DateInput(),
                            16.height,
                            const Label(label_incurred_costs_note,
                                isRequired: true),
                            const Note(),
                            32.height,
                            const Label(
                              label_incurred_costs_image,
                              note: msg_incurred_costs_image_note,
                            ),
                            const ImageCollection(),
                            48.height,
                            const SaveButton(),
                            if (widget.id != null) ...[
                              8.height,
                              const RemoveButton(),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
