import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/widgets/text/p_text.dart';
import 'package:nb_utils/nb_utils.dart';

class CardSection extends StatelessWidget {
  final Widget? child;
  final String? title;

  const CardSection({super.key, this.child, this.title});

  @override
  Widget build(BuildContext context) {
    // titleWidget is list of widget
    List<Widget>? titleWidgets = title != null
        ? <Widget>[
            PText(title ?? '', color: AppColors.textGreyColor),
            const Divider(color: AppColors.textGreyColor),
          ]
        : null;

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ...?titleWidgets,
            child ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
