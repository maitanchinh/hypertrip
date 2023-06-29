import 'package:flutter/cupertino.dart';
import 'package:hypertrip/utils/message.dart';

class PErrorPopup extends StatelessWidget {
  final String title;
  final String content;

  const PErrorPopup(
      {super.key, this.title = msg_error, this.content = msg_server_error});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
