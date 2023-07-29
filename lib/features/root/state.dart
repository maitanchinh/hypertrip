import 'package:hypertrip/domain/models/group/group.dart';

abstract class RootState {}

class RootInitState extends RootState {}

class RootLoadingState extends RootState {}

class RootSuccessState extends RootState {
  final Group? group;

  RootSuccessState({required this.group});
}

class RootErrorState extends RootState {
  final String message;

  RootErrorState(this.message);
}
