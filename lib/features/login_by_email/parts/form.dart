part of '../view.dart';

class Form extends StatefulWidget {
  const Form({super.key});

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _login() {
    final cubit = BlocProvider.of<LoginByEmailCubit>(context);
    String? alertTitle;
    String? alertContent;
    if (_emailController.text.isEmpty) {
      alertTitle = msg_alert_email_empty_title;
      alertContent = msg_alert_email_empty_content;
    } else if (_passwordController.text.isEmpty) {
      alertTitle = msg_alert_password_empty_title;
      alertContent = msg_alert_password_empty_content;
    }

    if (alertTitle != null) {
      showErrorPopup(context, title: alertTitle, content: alertContent!);
      return;
    }
    cubit.loginByEmail(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LoginByEmailCubit>(context);

    return BlocConsumer<LoginByEmailCubit, LoginByEmailState>(
      listener: (context, state) {
        if (state is LoginByEmailSuccessState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              RootPage.routeName,
              (route) => false); // remove all previous routes
          return;
        } else if (state is LoginByEmailFailedState) {
         showCupertinoModalPopup(context: context, builder: (context) => CupertinoAlertDialog(
            title: const Text(msg_login_failed_title),
            content: const Text(msg_login_failed_content),
            actions: [
              CupertinoDialogAction(child: const Text('OK'),onPressed: () => Navigator.of(context).pop(),)
            ],
          ));
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            PTextFormField(
              label: 'Email',
              controller: _emailController,
              obscureText: false,
              validator: LoginValidator.validateEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            PTextFormField(
              label: 'Password',
              controller: _passwordController,
              obscureText: true,
              validator: LoginValidator.validatePassword,
              keyboardType: TextInputType.text,
            ),
            ElevatedButton(onPressed: _login, child: const Text('Login')),
            // TextButton(
            //   onPressed: () {},
            //   child: const Text(
            //     'Forgot password?',
            //     style: TextStyle(
            //       color: AppColors.textGreyColor,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 70),
          ],
        );
      },
    );
  }
}
