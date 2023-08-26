part of '../view.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int selectCategoryIndex = 0;
  List<Slot> slots = [];
  bool locationWidth = true;

  @override
  void initState() {
    final cubit = BlocProvider.of<CurrentTourCubit>(context);
    slots = (cubit.state)
        .schedule
        .where((tour) => tour.latitude != null && tour.longitude != null)
        .toList()
      ..sort((a, b) => a.sequence!.compareTo(b.sequence as num));
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CurrentTourCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: ActionButton(
              icon: Resource.iconsAngleLeft,
              onPressed: () {
                finish(context);
              },
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: LocationTrackingComponent(
          slots: slots,
        ));
  }
}
