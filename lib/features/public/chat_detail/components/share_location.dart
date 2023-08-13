import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:hypertrip/utils/app_style.dart';

class ShareLocation extends StatelessWidget {
  final Message message;
  const ShareLocation({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String urlParse = '';
    String textContent = '';
    int httpIndex = message.message.indexOf("http");
    if (httpIndex != -1) {
      textContent = message.message.substring(0, httpIndex);
      urlParse = message.message.substring(httpIndex);
    } else {
      urlParse = message.message; // Phần trước "http"
    }
    return Container(
      constraints: const BoxConstraints(minHeight: 146, maxHeight: 200),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.telegram, size: 48, color: Colors.blueAccent),
              SizedBox(
                width: MediaQuery.of(context).size.width - 159,
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Live location \n",
                        style: AppStyle.fontOpenSanBold.copyWith(fontSize: 22)),
                    TextSpan(
                        text: textContent,
                        style: AppStyle.fontOpenSanBold.copyWith(
                            fontSize: 16, color: AppColors.textColor)),
                  ]),
                ),
              ),
            ],
          ),
          MaterialButton(
            height: 56,
            color: Colors.grey,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              side: BorderSide.none,
            ),
            onPressed: () {},
            child: Text('View location',
                style:
                    AppStyle.fontOpenSanRegular.copyWith(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
