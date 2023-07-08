import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hypertrip/domain/models/nearby/nearby_place.dart';
import 'package:hypertrip/domain/models/nearby/nearby_place_tip.dart';
import 'package:hypertrip/features/public/nearby/cubit.dart';
import 'package:hypertrip/features/public/nearby/state.dart';
import 'package:hypertrip/generated/resource.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/widgets/image/image.dart';
import 'package:hypertrip/widgets/text/p_small_text.dart';
import 'package:hypertrip/widgets/text/p_text.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';

part 'parts/detail_component.dart';

part 'parts/detail_screen.dart';

part 'parts/nearby_place.dart';

part 'parts/place.dart';

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
    return BlocProvider(
      create: (BuildContext context) => NearbyPlaceCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Unfocus the TextField when tapping outside
          _focusNode.unfocus();
        },
        child: SafeArea(
          child: SizedBox(
            height: context.height(),
            child: Column(
              children: [
                _searchBox(context).paddingSymmetric(horizontal: 16),
                16.height,
                _category(context).paddingLeft(16),
                32.height,
                SizedBox(
                  width: context.width(),
                  // padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: PText('Nearby You'),
                      ),
                      GestureDetector(
                        onTap: () {
                          _resetChildState();
                        },
                        child: SvgPicture.asset(
                          Resource.iconsCurrentLocation,
                          width: 24,
                          color: AppColors.primaryColor,
                        ),
                      )
                    ],
                  ),
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
    );
  }

  SizedBox _category(BuildContext context) {
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
                      color: Color(0xFFD7E8F9),
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: catIcons[index]),
                  ).onTap(() {
                    setState(() {
                      if (catNames[index] != 'All') {
                        query = catNames[index];
                        _searchController.text = catNames[index];
                      } else {
                        query = '';
                      }
                      _resetChild = true;
                    });
                    _resetChildState();
                  }),
                  8.height,
                  PSmallText(
                    catNames[index],
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
            color: whiteColor, borderRadius: BorderRadius.circular(16)),
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
