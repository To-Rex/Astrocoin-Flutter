import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
   // if (Platform.isIOS) WebView.platform = IOSWebView();

  }

  @override
  Widget build(BuildContext context) {
    //return WebView bottomsheet
    return const WebView(
      initialUrl: 'https://www.google.com',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}