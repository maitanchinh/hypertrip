part of '../view.dart';

class AmountInput extends StatelessWidget {
  const AmountInput({super.key});

  @override
  Widget build(BuildContext context) {
    const color = AppColors.textColor;

    const textStyle =
        TextStyle(color: color, fontSize: 30, fontWeight: FontWeight.w500);

    return Center(
      child: IntrinsicWidth(
        child: TextField(
          controller: BlocProvider.of<IncurredCostsActivityCubit>(context)
              .state
              .amountController,
          style: textStyle,
          decoration: const InputDecoration(
            hintText: '0',
            hintStyle: textStyle,
            suffixIcon: Text(
              'đ',
              style: textStyle,
            ),
            suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            border: UnderlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}
