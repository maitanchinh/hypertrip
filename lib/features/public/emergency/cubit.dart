import 'package:bloc/bloc.dart';

import 'state.dart';

class EmergencyCubit extends Cubit<EmergencyState> {
  EmergencyCubit() : super(EmergencyState().init());
}
