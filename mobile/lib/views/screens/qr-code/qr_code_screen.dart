import 'dart:io';
import 'dart:typed_data';

import 'package:diplom/helpers/get_helpers.dart';
import 'package:diplom/utils/app_style.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;

import 'package:share_plus/share_plus.dart';

class QrCodeScreen extends StatefulWidget {
  final String url;

  const QrCodeScreen({
    super.key,
    required this.url,
  });

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('QR Код'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: DeviceScreenConstants.screenHeight * 0.5,
            maxWidth: DeviceScreenConstants.screenWidth * 0.9,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                  maxWidth: 300,
                ),
                child: AppStyleCard(
                  backgroundColor: Colors.white,
                  child: RepaintBoundary(
                    key: _globalKey,
                    child: QrImageView(
                      data: widget.url,
                      backgroundColor: Colors.white,
                      eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: Colors.black,
                      ),
                      version: QrVersions.auto,
                      size: 200.0,
                      errorStateBuilder: (cxt, err) {
                        return Center(
                          child: Text(
                            'Что-то пошло не так. воспользуйтесь ссылкой напрямую: ${widget.url}',
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => _captureAndSavePNG(widget.url));
                  submitAction('QR код сохранен');
                },
                style: AppButtonStyle.basicButton.copyWith(
                  padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
                ),
                child: const Text('Сохранить QR-код',
                    style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _shareImage(String imagePath, String url) async {
    await Share.shareXFiles([XFile(imagePath)], text: 'Скачать динамику самочувствия: $url');
  }

  Future<void> _captureAndSavePNG(String url) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Проверка на null перед использованием
      if (_globalKey.currentContext != null) {
        RenderRepaintBoundary? boundary = _globalKey.currentContext!
            .findRenderObject() as RenderRepaintBoundary?;

        if (boundary != null) {
          ui.Image image = await boundary.toImage();
          ByteData? byteData =
              await image.toByteData(format: ui.ImageByteFormat.png);
          if (byteData != null) {
            Uint8List pngBytes = byteData.buffer.asUint8List();
            final directory = await getApplicationDocumentsDirectory();
            final imagePath =
                await File('${directory.path}/qr_image.png').create();
            await imagePath.writeAsBytes(pngBytes);

            await _shareImage(imagePath.path, url);
          }
        }
      }
    });
  }
}
