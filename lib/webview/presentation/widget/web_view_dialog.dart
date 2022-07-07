import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// [CustomWebViewDialog] accepts url and shows
/// simple [WebView] widget in an alert box.
class CustomWebViewDialog extends StatelessWidget {
  const CustomWebViewDialog({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.sp),
      ),
      content: ClipRRect(
        borderRadius: BorderRadius.circular(8.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: CloseButton(),
            ),
            SizedBox(
              height: 1.sw,
              width: 0.9.sw,
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: url,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
