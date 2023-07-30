

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/features/public/current_tour/cubit.dart';
import 'package:hypertrip/features/public/permission/cubit.dart';
import 'package:hypertrip/features/root/cubit.dart';
import 'package:hypertrip/features/tour_guide/activity/cubit.dart';
import 'package:hypertrip/features/tour_guide/attendance_activity/cubit.dart';

List<BlocProvider> multiBlocProvider() {
  return [
    BlocProvider<RootCubit>(
      lazy: false,
      create: (context) => RootCubit(),
    ),
    BlocProvider<CurrentTourCubit>(
      lazy: false,
      create: (context) => CurrentTourCubit(),
    ),
    BlocProvider<ActivityCubit>(
      lazy: false,
      create: (context) => ActivityCubit(context),
    ),
    BlocProvider<AttendanceActivityCubit>(
      create: (context) => AttendanceActivityCubit(),
    ),
    BlocProvider<CurrentLocationCubit>(
      lazy: false,
      create: (context) => CurrentLocationCubit())
  ];
}
