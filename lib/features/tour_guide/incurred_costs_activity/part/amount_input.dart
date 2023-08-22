part of '../view.dart';

class AmountInput extends StatelessWidget {
  const AmountInput({super.key});

  @override
  Widget build(BuildContext context) {
    const color = AppColors.textColor;

    const textStyle =
        TextStyle(color: color, fontSize: 30, fontWeight: FontWeight.w500);

    final state = BlocProvider.of<IncurredCostsActivityCubit>(context).state;

    return Center(
      child: IntrinsicWidth(
        child: TextField(
          maxLength: IncurredCostsActivityState.maxAmountLength,
          controller: state.amountController,
          inputFormatters: [state.amountFormatter],
          style: textStyle,
          decoration: InputDecoration(
            hintText: state.amountFormatter.format('0'),
            hintStyle: textStyle,
            counterText: '',
            suffixIconConstraints:
                const BoxConstraints(minWidth: 0, minHeight: 0),
            border: const UnderlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}
