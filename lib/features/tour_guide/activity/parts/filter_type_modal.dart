part of '../view.dart';

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
              title: Text(e.label),
              enabled: true,
              leading: SvgPicture.asset(
                e.icon,
                width: 20,
                color: e.type == currentType
                    ? AppColors.primaryColor
                    : AppColors.textColor,
              ),
              selected: e.type == currentType,
              onTap: () => {
                cubit.setFilter(filterType: e.type),
                Navigator.of(context).pop(),
              },
            ),
          ),
        ],
      ),
    ));
  }
}
