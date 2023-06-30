import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit.dart';

class NearbyPage extends StatelessWidget {
  const NearbyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NearbyCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<NearbyCubit>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Nearby')),
    );
  }
}
