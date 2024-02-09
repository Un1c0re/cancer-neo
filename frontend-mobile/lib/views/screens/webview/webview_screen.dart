import 'package:diplom/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  const WebViewScreen({
    super.key, 
    required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    final url = widget.url;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.activeColor,
        title: const Text('Внешние ресурсы'),
        centerTitle: true,
      ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri.uri(Uri.parse(url)),
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                inAppWebViewController = controller;
              },
              onProgressChanged: (InAppWebViewController contorller, int progress) {
                setState(() {
                  _progress = progress / 100;
                });
              },
            ),
            _progress < 1 ? LinearProgressIndicator(
              color: AppColors.primaryColor,
              value: _progress,
            ): const SizedBox(),
          ],
        )
      ),
    );
  }
}