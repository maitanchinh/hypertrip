part of '../view.dart';

class Form extends StatefulWidget {
  const Form({super.key});

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();

    _phoneController.text = '84768049528';
    _passwordController.text = '123123';

    super.initState();
  }

  void _login() {
    final cubit = BlocProvider.of<LoginByPhoneCubit>(context);
    String? alertTitle;
    String? alertContent;
    if (_phoneController.text.isEmpty) {
      alertTitle = msg_alert_phone_empty_title;
      alertContent = msg_alert_phone_empty_content;
    } else if (_passwordController.text.isEmpty) {
      alertTitle = msg_alert_password_empty_title;
      alertContent = msg_alert_password_empty_content;
    }

    if (alertTitle != null) {
      showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: Text(alertTitle!),
                content: Text(alertContent!),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ));
      return;
    }
    cubit.loginByPhone(
        phone: _phoneController.text, password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginByPhoneCubit, LoginByPhoneState>(
      listener: (context, state) {
        if (state is LoginByPhoneSuccessState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              CurrentTourPage.routeName, (route) => false);
        } else if (state is LoginByPhoneFailedState) {}
      },
      builder: (context, state) {
        return Column(
          children: [
            PTextFormField(
              label: 'Phone',
              controller: _phoneController,
              obscureText: false,
              validator: LoginValidator.validatePhoneNumber,
              keyboardType: TextInputType.phone,
            ),
            PTextFormField(
              label: 'Password',
              controller: _passwordController,
              obscureText: true,
              validator: LoginValidator.validatePassword,
              keyboardType: TextInputType.text,
            ),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Forgot password?',
                style: TextStyle(
                  color: AppColors.textGreyColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 70),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
