import 'package:diplom/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebInfoWidget extends StatefulWidget {
  const WebInfoWidget({
    super.key,
  });

  @override
  State<WebInfoWidget> createState() => _WebInfoWidgetState();
}

class _WebInfoWidgetState extends State<WebInfoWidget> {
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;

  @override
void initState() {
  super.initState();
  // Устанавливаем стиль системной панели статуса
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.primaryColor, // Вы можете выбрать нужный цвет
    statusBarIconBrightness: Brightness.light, // Иконки статуса бара светлые (для темного фона)
  ));
}

  @override
  Widget build(BuildContext context) {
    final url = dotenv.env['WEB_INFO']!;
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri.uri(Uri.parse(url)),
            ),
            onWebViewCreated: (InAppWebViewController controller) {
              inAppWebViewController = controller;
            },
            onProgressChanged:
                (InAppWebViewController contorller, int progress) {
              setState(() {
                _progress = progress / 100;
              });
            },
          ),
          _progress < 1
              ? LinearProgressIndicator(
                  color: AppColors.primaryColor,
                  value: _progress,
                )
              : const SizedBox(),
        ],
      )),
    );
  }
}
