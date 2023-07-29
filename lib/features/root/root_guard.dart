import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/features/root/cubit.dart';
import 'package:hypertrip/features/root/state.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/popup/p_error_popup.dart';
import 'package:nb_utils/nb_utils.dart';

class RootGuard extends StatefulWidget {
  final Widget child;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  const RootGuard({
    super.key,
    required this.child,
    this.loadingWidget,
    this.errorWidget,
  });

  @override
  State<RootGuard> createState() => _RootGuardState();
}

class _RootGuardState extends State<RootGuard> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RootCubit, RootState>(
      listener: (context, state) {
        if (state is RootErrorState) {
          showErrorPopup(context, content: state.message);
        } else if (state is RootSuccessState && state.group == null) {
          showErrorPopup(context, content: msg_tour_group_not_found);
        }
      },
      builder: (context, state) {
        if (state is RootLoadingState) {
          return widget.loadingWidget ??
              const Center(child: CircularProgressIndicator());
        }

        if (state is RootErrorState) {
          return widget.errorWidget ?? 0.width;
        }

        if (state is RootSuccessState) {
          if (state.group == null) {
            return widget.errorWidget ?? 0.width;
          }

          return widget.child;
        }

        return 0.width;
      },
    );
  }
}
