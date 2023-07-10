import 'package:flutter/cupertino.dart';
import 'package:hypertrip/utils/message.dart';

Future showErrorPopup(BuildContext context,
        {String title = msg_error, required String content}) =>
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
