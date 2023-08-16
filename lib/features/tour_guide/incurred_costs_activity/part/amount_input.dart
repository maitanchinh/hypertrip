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
          maxLength: IncurredCostsActivityState.maxAmountLength,
          controller: BlocProvider.of<IncurredCostsActivityCubit>(context)
              .state
              .amountController,
          inputFormatters: [CurrencyFormatter.vi],
          style: textStyle,
          decoration: InputDecoration(
            hintText: CurrencyFormatter.vi.format('0'),
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
