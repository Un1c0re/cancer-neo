import 'package:cancerneo/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomeNeoWidget extends StatefulWidget {
  const HomeNeoWidget({
    super.key,
  });

  @override
  State<HomeNeoWidget> createState() => _HomeNeoWidgetState();
}

class _HomeNeoWidgetState extends State<HomeNeoWidget> {
  double _progress = 0;
  bool _isLoadError = false;
  late InAppWebViewController inAppWebViewController;

  @override
  void initState() {
    super.initState();
    // Устанавливаем стиль системной панели статуса
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor, // Вы можете выбрать нужный цвет
      statusBarIconBrightness:
          Brightness.light, // Иконки статуса бара светлые (для темного фона)
    ));
  }

  @override
  Widget build(BuildContext context) {
    final url = dotenv.env['WEB_INFO']!;
    return SafeArea(
      child: Scaffold(
          body: !_isLoadError
              ? Stack(
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
                      onReceivedError: (InAppWebViewController controller,
                          WebResourceRequest request, WebResourceError error) {
                        setState(() {
                          _progress = 100;
                          setState(() {
                            _isLoadError = true;
                          });
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
                )
              : const Center(
                  child: Text(
                    'Раздел недоступен\nНет подключения к интернету',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.activeColor,
                    ),
                  ),
                )),
    );
  }
}
