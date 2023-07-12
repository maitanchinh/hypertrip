part of '../view.dart';

final List<Tuple2<ActivityType, IconData>> activitiesTypeData = [
  const Tuple2(ActivityType.All, Icons.filter_list),
  const Tuple2(ActivityType.Attendance, Icons.check_circle_outline),
  const Tuple2(ActivityType.CheckIn, Icons.check_circle_outline),
  const Tuple2(ActivityType.Custom, Icons.check_circle_outline),
];

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Timer? _debounce;

  _onSearchChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<ActivityCubit>().setFilter(filterText: text);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityCubit, ActivityState>(
      listener: (context, state) {},
      buildWhen: (previous, current) => current is ActivityFilterChangedState,
      builder: (context, state) {
        return SafeSpace(
          child: Container(
            height: ActivityConfig.searchInputHeight,
            padding: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //* Icon search
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Icon(
                    Icons.search,
                    size: Theme.of(context).textTheme.titleMedium!.fontSize,
                  ),
                ),
                //* Search input
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleMedium!.fontSize,
                    ),
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: "Search",
                      border: InputBorder.none,
                    ),
                    onChanged: _onSearchChanged,
                  ),
                ),
                //* Type filter
                Builder(
                  builder: (context) {
                    final cubit = BlocProvider.of<ActivityCubit>(context);
                    final currentType = cubit.state.filterType;

                    return Container(
                      padding: const EdgeInsets.only(left: 8, right: 16),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          activitiesTypeData
                              .firstWhere((e) => e.item1.name == currentType)
                              .item2,
                          color: Colors.white,
                        ),
                      ),
                    ).onTap(() {
                      showSheetModal(
                        context: context,
                        builder: (context) => const FilterTypeModal(),
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
