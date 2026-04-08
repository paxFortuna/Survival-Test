import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebBrowerScreen extends StatefulWidget {
  const WebBrowerScreen({super.key});

  @override
  State<WebBrowerScreen> createState() => _WebBrowerScreenState();
}

class _WebBrowerScreenState extends State<WebBrowerScreen> {
  final WebViewController _webViewController =
      WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse('https://flutter.dev'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Web Browser'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
          PopupMenuButton<String>(
            onSelected: (value) {
              _webViewController.loadRequest(Uri.parse(value));
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem<String>(
                    value: 'https://www.google.com',
                    child: Text('구글'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'https://www.naver.com',
                    child: Text('네이버'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'https://www.kakao.com',
                    child: Text('카카오'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'http://www.fortuneWheel.shop',
                    child: Text('포춘휠'),
                  ),
                ],
          ),
        ],
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (await _webViewController.canGoBack()) {
            await _webViewController.goBack();
            return;
          }
        },
        child: WebViewWidget(controller: _webViewController),
      ),

      // onPopInvoked: (dipPop) async {
      //   if (await _webViewController.canGoBack()) {
      //     await _webViewController.goBack();
      //   }
      // },
    );
  }
}
