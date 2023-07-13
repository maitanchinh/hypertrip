part of '../../view.dart';

class SelectTypeToCreateActivityModal extends StatefulWidget {
  const SelectTypeToCreateActivityModal({super.key});

  @override
  State<SelectTypeToCreateActivityModal> createState() =>
      _SelectTypeToCreateActivityModalState();
}

class _SelectTypeToCreateActivityModalState
    extends State<SelectTypeToCreateActivityModal> {
  @override
  Widget build(BuildContext context) {
    var items = activitiesTypeData.where((e) => e.item1 != ActivityType.All);

    //  ...activitiesTypeData.where((e) => e.item1 != ActivityType.All).map(
    //           (e) => ListTile(
    //             title: Text(e.item1.label),
    //             enabled: true,
    //             leading: Icon(e.item2),
    //             onTap: () => {
    //               // cubit.setFilter(
    //               //     filterType: e.item1.name),
    //               // Navigator.of(context).pop(),
    //             },
    //           ),
    //         ),
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoListSection(
              header: const Text('Select new activity'),
              children: items
                  .map(
                    (e) => CupertinoListTile.notched(
                      title: Text(e.item1.label),
                      trailing: Icon(
                        e.item2,
                        color: CupertinoColors.systemGrey2,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
