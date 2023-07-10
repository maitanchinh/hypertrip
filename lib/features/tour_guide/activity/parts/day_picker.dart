import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/features/public/current_tour/cubit.dart';

class DayPicker extends StatefulWidget {
  const DayPicker({super.key});

  @override
  State<DayPicker> createState() => _DayPickerState();
}

class _DayPickerState extends State<DayPicker> {
  @override
  Widget build(BuildContext context) {
    var currentTourCubit = BlocProvider.of<CurrentTourCubit>(context);

    return Container();
  }
}
