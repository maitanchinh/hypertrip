import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/features/tour_guide/activity/cubit.dart';
import 'package:hypertrip/features/tour_guide/incurred_costs_activity/cubit.dart';
import 'package:hypertrip/features/tour_guide/incurred_costs_activity/state.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/safe_space.dart';
import 'package:nb_utils/nb_utils.dart';

part 'part/amount_input.dart';
part 'part/app_bar.dart';
part 'part/card.dart';
part 'part/image_collection.dart';
part 'part/note.dart';
part 'part/time.dart';

class IncurredCostsActivity extends StatefulWidget {
  static const routeName = '/tour_guide/incurred_costs_activity';

  const IncurredCostsActivity({super.key});

  @override
  State<IncurredCostsActivity> createState() => _IncurredCostsActivityState();
}

class _IncurredCostsActivityState extends State<IncurredCostsActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: AppColors.bgLightColor,
      body: BlocProvider(
        create: (context) => IncurredCostsActivityCubit(),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          16.height,
          const Time(),
          16.height,
          SafeSpace(
            child: Card(
              child: Column(children: [
                const AmountInput(),
                16.height,
                const Note(),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
