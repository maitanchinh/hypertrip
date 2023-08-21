part of '../view.dart';

class Label extends StatelessWidget {
  final String? data;
  final String? note;
  final String? hint;
  final Widget? bottom;
  final bool isRequired;

  const Label(
    this.data, {
    super.key,
    this.note,
    this.hint,
    this.bottom = const SizedBox(height: 16),
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data != null)
            Row(
              children: [
                Text(
                  data!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (isRequired)
                  Text(
                    '*',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: AppColors.redColor),
                  ),
              ],
            ),
          if (note != null)
            Text(
              note!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.textGreyColor),
            ),
          if (hint != null)
            Text(
              hint!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.textGreyColor),
            ),
          if (bottom != null) bottom!,
        ],
      ),
    );
  }
}
