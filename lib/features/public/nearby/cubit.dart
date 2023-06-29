import 'package:bloc/bloc.dart';

import 'state.dart';

class NearbyCubit extends Cubit<NearbyState> {
  NearbyCubit() : super(NearbyState().init());
}
