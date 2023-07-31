part of '../view.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isPermissionDenied = false;
  bool isPermissionGranted = false;
  TravelerAttendanceCubit? _attendanceCubit;

  @override
  void initState() {
    _attendanceCubit = BlocProvider.of<TravelerAttendanceCubit>(context);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _requestCameraPermission();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isPermissionDenied) {
      showErrorPopup(context, content: msg_camera_required);
      Navigator.pop(context);
    }

    return BlocConsumer<TravelerAttendanceCubit, TravelerAttendanceState>(
      listener: (context, state) {
        if (state.error != null) {
          showPopup(context,
              title: msg_error,
              content: state.error ?? '',
              actions: [
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _attendanceCubit?.reset();
                    this.controller?.resumeCamera();
                  },
                  child: const Text('OK'),
                ),
              ]);
        }

        if (state.loading) {
          EasyLoading.show(status: msg_loading);
        } else {
          EasyLoading.dismiss();
        }
      },
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            if (isPermissionGranted)
              QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: AppColors.primaryColor,
                  borderWidth: 10,
                  borderLength: 20,
                  borderRadius: 10,
                  cutOutSize: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
          ],
        );
      },
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((data) async {
      if (data.code != null) {
        this.controller?.pauseCamera();
        HapticFeedback.vibrate();
        _attendanceCubit?.attend(data.code);
      }
    });
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status == PermissionStatus.granted) {
      setState(() {
        isPermissionGranted = true;
      });
    } else {
      final result = await Permission.camera.request();
      setState(() {
        isPermissionDenied = result.isDenied;
      });
    }
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
