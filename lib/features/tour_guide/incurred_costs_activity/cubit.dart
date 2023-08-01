import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/features/tour_guide/incurred_costs_activity/state.dart';

class IncurredCostsActivityCubit extends Cubit<IncurredCostsActivityState> {
  IncurredCostsActivityCubit() : super(IncurredCostsActivityState.initial());

  void submit() {}

  void reset() {}
}
