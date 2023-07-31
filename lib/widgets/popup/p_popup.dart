import 'package:flutter/cupertino.dart';

Future showPopup(BuildContext context,
        {required String title,
        required String content,
        List<Widget>? actions}) =>
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions ??
            [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
      ),
    );
