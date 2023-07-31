import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/validations/login_validator.dart';
import 'package:hypertrip/features/login_by_email/view.dart';
import 'package:hypertrip/features/login_by_phone/state.dart';
import 'package:hypertrip/features/root/view.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/theme/theme.dart';
import 'package:hypertrip/widgets/p_text_form_field.dart';
import 'package:hypertrip/widgets/safe_space.dart';

import '../../utils/message.dart';
import '../public/current_tour/view.dart';
import 'cubit.dart';

part 'parts/footer.dart';
part 'parts/form.dart';
part 'parts/header.dart';

class LoginByPhonePage extends StatelessWidget {
  static const routeName = '/login-by-phone';

  const LoginByPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginByPhoneCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<LoginByPhoneCubit>(context);

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
