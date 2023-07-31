import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hypertrip/features/traveler/attendance/cubit.dart';
import 'package:hypertrip/features/traveler/attendance/parts/attendance_status.dart';
import 'package:hypertrip/features/traveler/attendance/state.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/popup/p_error_popup.dart';
import 'package:hypertrip/widgets/popup/p_popup.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
        bottom: false,
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
