part of '../view.dart';

class DayPicker extends StatefulWidget {
  const DayPicker({super.key});

  @override
  State<DayPicker> createState() => _DayPickerState();
}

class _DayPickerState extends State<DayPicker> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityCubit, ActivityState>(
      listener: (context, state) {
        if (state is ActivityErrorState) {
          showErrorPopup(context, content: state.message);
        }
      },
      builder: (context, state) {
        if (state is ActivityLoadingState) {
          return const SizedBox();
        }

        if (state is ActivityErrorState) {
          return const SizedBox();
        }

        return _buildBody();
      },
    );
  }

  Widget _buildBody() {
    return BlocConsumer<ActivityCubit, ActivityState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<ActivityCubit>(context);

        return DefaultTabController(
          length: cubit.state.totalDays,
          child: TabBar(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            onTap: (index) {
              cubit.setFilter(day: index);
            },
            isScrollable: true,
            labelPadding: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            indicator: const BoxDecoration(
              color: Colors.transparent,
            ),
            tabs: [
              for (var i = 0; i < cubit.state.totalDays; i++)
                Container(
                  height: ActivityConfig.dayPickerBtnHeight,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: cubit.state.selectedDay == i
                        ? AppColors.primaryColor
                        : AppColors.primaryColor.withOpacity(0.5),
                  ),
                  child: Center(child: Text("Day ${i + 1}")),
                ),
            ],
          ),
        );
      },
    );
  }
}
