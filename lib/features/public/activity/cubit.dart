import 'package:bloc/bloc.dart';

import 'state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit() : super(ActivityState().init());
}
