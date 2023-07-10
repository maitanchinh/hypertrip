import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/features/public/current_tour/cubit.dart';
import 'package:hypertrip/features/tour_guide/activity/cubit.dart';

List<BlocProvider> multiBlocProvider() {
  return [
    BlocProvider<CurrentTourCubit>(
      lazy: false,
      create: (context) => CurrentTourCubit(),
    ),
    BlocProvider<ActivityCubit>(
      lazy: false,
      create: (BuildContext context) => ActivityCubit(context),
    ),
  ];
}