import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/validations/login_validator.dart';
import 'package:hypertrip/features/login_by_email/state.dart';
import 'package:hypertrip/features/login_by_phone/view.dart';
import 'package:hypertrip/features/public/current_tour/view.dart';
import 'package:hypertrip/features/root/view.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/theme/theme.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/p_text_form_field.dart';
import 'package:hypertrip/widgets/popup/p_error_popup.dart';
import 'package:hypertrip/widgets/safe_space.dart';

import 'cubit.dart';

part 'parts/footer.dart';
part 'parts/form.dart';
part 'parts/header.dart';

class LoginByEmailPage extends StatelessWidget {
  static const routeName = '/login-by-email';

  const LoginByEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginByEmailCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<LoginByEmailCubit>(context);

    return Scaffold(
      backgroundColor: AppColors.bgLightColor,
      resizeToAvoidBottomInset: false,
      body: SafeSpace(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Header(),
                  Form(),
                ],
              ),
            ),
            const Footer(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
