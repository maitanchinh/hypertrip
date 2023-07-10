part of '../view.dart';

final List<Tuple2<ActivityType, IconData>> activitiesTypeData = [
  const Tuple2(ActivityType.All, Icons.filter_list),
  const Tuple2(ActivityType.Attendance, Icons.check_circle_outline),
  const Tuple2(ActivityType.CheckIn, Icons.check_circle_outline),
  const Tuple2(ActivityType.Custom, Icons.check_circle_outline),
];

class Search extends StatelessWidget {
  final double fontSize;

  const Search({super.key, this.fontSize = kTextSizeSmall});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityCubit, ActivityState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeSpace(
          child: Container(
            height: 40,
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
                    size: fontSize,
                  ),
                ),
                //* Search input
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: fontSize),
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: "Search",
                      border: InputBorder.none,
                    ),
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
                    ).onTap(
                      () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SafeArea(
                              child: Wrap(
                                children: [
                                  ...activitiesTypeData.map(
                                    (e) => ListTile(
                                      title: Text(e.item1.name),
                                      enabled: true,
                                      leading: Icon(e.item2),
                                      selected: e.item1.name == currentType,
                                      onTap: () => {
                                        cubit.changeActivityType(e.item1.name),
                                        Navigator.of(context).pop(),
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
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
