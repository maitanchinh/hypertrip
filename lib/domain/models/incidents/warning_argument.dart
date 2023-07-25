import 'package:hypertrip/features/public/warning_incident/interactor/warning_incident_bloc.dart';

class WarningArgument {
  List<LocationTour> locationTour;
  String tripId;

  WarningArgument(this.locationTour,this.tripId);
}