import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hypertrip/features/public/permission/state.dart';

class CurrentLocationCubit extends Cubit<CurrentLocationState> {
  CurrentLocationCubit() : super(CurrentLocationState()) {
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      emit(CurrentLocationState());
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {}
      }
      Geolocator.getPositionStream().listen((Position position) {
        emit(LoadCurrentLocationSuccessState(location: position));
      });
    } on Exception catch (e) {
      emit(LoadCurrentLocationFailedState(msg: e.toString()));
    }
  }
}

//Stream Subcription
class StreamSubscriptionCubit extends Cubit<StreamSubscription?> {
  StreamSubscriptionCubit() : super(null);

  void setSubscription(StreamSubscription subscription) {
    emit(subscription);
  }

  void cancelSubscription() {
    state?.cancel();
    emit(null);
  }
}
