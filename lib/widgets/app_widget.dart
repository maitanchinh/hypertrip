import 'package:flutter/material.dart';
import 'package:hypertrip/utils/page_states.dart';
import 'package:hypertrip/widgets/no_data_widget.dart';

class AppWidget extends StatelessWidget {
  final PageState status;
  final VoidCallback failureOnPress;
  final Widget child;
  final String errorText;
  final bool loadingStack;

  const AppWidget({
    Key? key,
    required this.child,
    required this.status,
    required this.failureOnPress,
    required this.errorText,
    this.loadingStack = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case PageState.initial:
        return const Center(child: CircularProgressIndicator());
      case PageState.loading:
        if (loadingStack) {
          return Stack(
            children: [child, const Center(child: CircularProgressIndicator())],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      case PageState.failure:
        return NoDataWidget(content: "Error $errorText", onPressed: failureOnPress);
      case PageState.success:
        return child;
    }
  }
}
