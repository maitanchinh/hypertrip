part of '../view.dart';

class AmountInput extends StatefulWidget {
  const AmountInput({super.key});

  @override
  State<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  final CurrencyTextInputFormatter _formatter = CurrencyFormatter.vi;
  final TextEditingController _controller = TextEditingController();
  IncurredCostsActivityCubit? _cubit;

  @override
  void initState() {
    super.initState();

    _controller.addListener(_onChange);

    _cubit = context.read<IncurredCostsActivityCubit>();
  }

  @override
  void dispose() {
    _controller.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() {
    _cubit?.onStateChanged(_cubit!.state.copyWith(
      amount: _formatter.getUnformattedValue().toDouble(),
      isAmountValid: _formatter.getUnformattedValue() > 0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    const color = AppColors.textColor;

    const textStyle =
        TextStyle(color: color, fontSize: 30, fontWeight: FontWeight.w500);

    return Center(
      child: IntrinsicWidth(
        child: BlocListener<IncurredCostsActivityCubit,
            IncurredCostsActivityState>(
          listener: (context, state) {
            if (state.amount != _formatter.getUnformattedValue()) {
              _controller.text = _formatter.formatDouble(state.amount);
              _controller.selection = TextSelection.collapsed(
                  offset: _formatter.formatDouble(state.amount).length);
            }
          },
          child: TextFormField(
            maxLength: IncurredCostsActivityState.maxAmountLength,
            inputFormatters: [_formatter],
            controller: _controller,
            style: textStyle,
            decoration: InputDecoration(
              hintText: _formatter.format('0'),
              hintStyle: textStyle,
              counterText: '',
              suffixIconConstraints:
                  const BoxConstraints(minWidth: 0, minHeight: 0),
              border: const UnderlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ),
    );
  }
}
