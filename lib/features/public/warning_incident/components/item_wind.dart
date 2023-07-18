import 'package:flutter/material.dart';
import 'package:hypertrip/features/public/warning_incident/components/item_weather.dart';
import 'package:hypertrip/utils/app_assets.dart';

class ItemWind extends StatelessWidget {
  final int hPa;
  final int humidity;
  final double windKph;
  const ItemWind({Key? key, required this.hPa, required this.humidity, required this.windKph})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ItemWeather(icon: AppAssets.icons_ic_wind_svg, text: '${hPa}hPa'),
          ItemWeather(icon: AppAssets.icons_ic_droplet_svg, text: '$humidity%'),
          ItemWeather(icon: AppAssets.icons_ic_wind_svg, text: '${windKph}km/h'),
        ],
      ),
    );
  }
}
