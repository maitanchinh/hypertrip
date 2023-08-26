import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_assets.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox({
    required this.value,
    required this.onChanged,
  });
  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _isChecked = false;
@override
  void initState() {
    super.initState();
    _isChecked = widget.value;
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
          widget.onChanged(_isChecked);
        });
      },
      // child: AnimatedContainer(
      //   duration: Duration(milliseconds: 300),
      //   width: 24,
      //   height: 24,
      //   decoration: BoxDecoration(
      //     shape: BoxShape.circle,
      //     border: Border.all(color: Colors.grey),
      //     color: transparentColor,
      //   ),
      //   child: Center(
      //     child: _isChecked
      //         ? Transform.scale(scale: 0.7, child: SvgPicture.asset(AppAssets.icons_check_svg, color: AppColors.primaryColor,))
      //         : SizedBox.shrink(),
      //   ),
      // ),
      child: AnimatedContainer(
        width: 30, // Adjust size as needed
        height: 30, // Adjust size as needed
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isChecked ? AppColors.primaryColor : Colors.transparent,
          border: Border.all(color: _isChecked ? AppColors.primaryColor : Colors.grey, width: 1),
        ),
        duration: const Duration(milliseconds: 300),
        child: _isChecked
            ? Transform.scale(scale: 0.7, child: SvgPicture.asset(AppAssets.icons_check_svg, color: white,))
            : const SizedBox.shrink(),
      ),
    );
  }
}
