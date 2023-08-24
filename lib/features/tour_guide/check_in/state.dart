class CheckInActivityState {
  String? checkInId;

  CheckInActivityState copyWith({
    String? checkInId
  }) {
    return CheckInActivityState()..checkInId = checkInId ?? this.checkInId;
  }
}



class CheckInActivityLoadingState extends CheckInActivityState {
  
}

class CheckInActivitySuccessState extends CheckInActivityState {
  CheckInActivitySuccessState(CheckInActivityState state){
    checkInId = state.checkInId;
  }
}

class CheckInActivityErrorState extends CheckInActivityState {
  final String msg;
  CheckInActivityErrorState({required this.msg});
}
