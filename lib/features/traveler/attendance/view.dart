import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/features/traveler/attendance/cubit.dart';
import 'package:hypertrip/features/traveler/attendance/parts/attendance_status.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/popup/p_error_popup.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:nb_utils/nb_utils.dart';

part 'parts/qr_scanner.dart';

class Attendance extends StatefulWidget {
  static const routeName = '/traveler/attendance';

  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: const [
            Expanded(child: QrScanner()),
            AttendanceStatus(),
          ],
        ),
      ),
    );
  }
}
