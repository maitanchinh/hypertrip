import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hypertrip/domain/models/nearby/nearby_place.dart';
import 'package:hypertrip/features/public/nearby/cubit.dart';
import 'package:hypertrip/features/public/nearby/state.dart';
import 'package:hypertrip/features/public/permission/cubit.dart';
import 'package:hypertrip/features/public/permission/state.dart';
import 'package:hypertrip/generated/resource.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:hypertrip/widgets/app_bar.dart';
import 'package:hypertrip/widgets/button/action_button.dart';
import 'package:hypertrip/widgets/space/gap.dart';
import 'package:hypertrip/widgets/text/p_small_text.dart';
import 'package:hypertrip/widgets/text/p_text.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/image/image.dart';
import '../../../widgets/safe_space.dart';

part 'parts/carousel.dart';
part 'parts/detail_component.dart';
part 'parts/detail_screen.dart';
part 'parts/map.dart';
part 'parts/nearby_place.dart';
part 'parts/place.dart';
part 'parts/place_photo.dart';

class NearbyPage extends StatefulWidget {
  static const routeName = '/nearby';

  const NearbyPage({super.key});

  @override
  State<NearbyPage> createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> {
  Key _childKey = UniqueKey();
  bool _resetChild = false;
  final _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String searchQuery = '';
  String query = '';
  bool isSearch = false;
  List catNames = ['All', "Food", "Coffee", "NightLife", "Fun", "Shopping"];
  List<SvgPicture> catIcons = [
    SvgPicture.asset(
      Resource.iconsAll,
      width: 32,
      height: 31,
    ),
    SvgPicture.asset(
      Resource.iconsPizza,
    ),
    SvgPicture.asset(
      Resource.iconsCoffee,
    ),
    SvgPicture.asset(
      Resource.iconsNightlife,
    ),
    SvgPicture.asset(
      Resource.iconsFun,
    ),
    SvgPicture.asset(
      Resource.iconsShopping,
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _resetChildState() {
    setState(() {
      _childKey = UniqueKey(); // Update the key to trigger a rebuild
      _resetChild = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Widget _buildPage(BuildContext context) {
    final currentLocationCubit = BlocProvider.of<CurrentLocationCubit>(context);
    final nearbyPlaceCubit = BlocProvider.of<NearbyPlaceCubit>(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Unfocus the TextField when tapping outside
          _focusNode.unfocus();
        },
        child: RefreshIndicator(
          onRefresh: () async {
            nearbyPlaceCubit.refresh();
          },
          child: SafeArea(
            child: SizedBox(
              height: context.height(),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: context.width() * 0.9,
                        child: _searchBox(context)
                            .paddingSymmetric(horizontal: 16),
                      ),
                      SizedBox(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                              NearbyMap.routeName,
                              arguments: NearbyMap(
                                  places: (nearbyPlaceCubit.state
                                          as LoadNearbyPlaceSuccessState)
                                      .nearbyPlace!
                                      .results)),
                          child: SvgPicture.asset(
                            AppAssets.icons_map_svg,
                            width: 24,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  16.height,
                  _category(context).paddingLeft(16),
                  32.height,
                  SizedBox(
                    width: context.width(),
                    // padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: PText('Nearby You'),
                  ).paddingOnly(left: 16, right: 16, bottom: 16),
                  NearbyPlace(
                    query: query,
                    reset: _resetChild,
                    key: _childKey,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _category(BuildContext context) {
    final cubit = BlocProvider.of<NearbyPlaceCubit>(context);

    return SizedBox(
      height: 68,
      width: context.width(),
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: catNames.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: (MediaQuery.of(context).size.width - 32) / catNames.length,
              child: Column(
                children: [
                  Container(
                    height: 46,
                    width: 46,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryLightColor,
                      shape: BoxShape.circle,
                    ),
                    child: Transform.scale(scale: 0.7, child: catIcons[index]),
                  ).onTap(() {
                    setState(() {
                      if (catNames[index] != 'All') {
                        query = catNames[index];
                        _searchController.text = catNames[index];
                      } else {
                        query = '';
                      }
                      // _resetChild = true;
                    });
                    // _resetChildState();
                    cubit.getNearbyPlace(query);
                  }),
                  8.height,
                  PText(
                    catNames[index],
                    size: 12,
                  )
                ],
              ),
            );
          }),
    );
  }

  Container _searchBox(BuildContext context) {
    final cubit = BlocProvider.of<NearbyPlaceCubit>(context);

    return Container(
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(50)),
        child: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'Search for a place',
            prefixIcon: SizedBox(
              width: 16,
              height: 16,
              child: Transform.scale(
                scale: 0.5,
                child: SvgPicture.asset(
                  Resource.iconsSearch,
                  // width: 16,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
            border: InputBorder.none,
          ),
          onSubmitted: (_) {
            cubit.getNearbyPlace(_searchController.text);
            // _resetChildState();
            // setState(() {
            //   query = _searchController.text;
            //   _resetChild = true;
            // });
          },
        ));
  }
}
