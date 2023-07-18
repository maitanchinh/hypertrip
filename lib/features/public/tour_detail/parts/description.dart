part of '../view.dart';

Widget _buildDescription(LoadTourDetailSuccessState state) {
  return Readmore.ReadMoreText(
    state.tour.description ?? "",
    trimLines: 2,
    trimMode: Readmore.TrimMode.Line,
    delimiter: '...',
    trimCollapsedText: label_read_more,
    trimExpandedText: label_read_less,
    style: const TextStyle(
      fontSize: 14,
      color: AppColors.textColor,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    moreStyle: moreTextStyle(),
    lessStyle: moreTextStyle(),
  );
}
