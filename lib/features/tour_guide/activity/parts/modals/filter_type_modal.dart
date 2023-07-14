part of '../../view.dart';

class FilterTypeModal extends StatefulWidget {
  const FilterTypeModal({super.key});

  @override
  State<FilterTypeModal> createState() => _FilterTypeModalState();
}

class _FilterTypeModalState extends State<FilterTypeModal> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ActivityCubit>(context);
    final currentType = cubit.state.filterType;

    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ...activitiesTypeData.map(
            (e) => ListTile(
              title: Text(e.item1.label),
              enabled: true,
              leading: Icon(e.item2),
              selected: e.item1.name == currentType,
              onTap: () => {
                cubit.setFilter(filterType: e.item1.name),
                Navigator.of(context).pop(),
              },
            ),
          ),
        ],
      ),
    ));
  }
}
