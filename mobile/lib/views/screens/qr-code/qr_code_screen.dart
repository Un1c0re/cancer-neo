import 'dart:io';
import 'dart:typed_data';

import 'package:diplom/utils/app_style.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;

class QrCodeScreen extends StatefulWidget {
  final String url;

  QrCodeScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  final GlobalKey _globalKey = GlobalKey();

  String _savedFile = "";

    Future<void> _captureAndSavePNG() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        RenderRepaintBoundary? boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
        if (boundary != null) {
          ui.Image image = await boundary.toImage();
          ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
          if (byteData != null) {
            Uint8List pngBytes = byteData.buffer.asUint8List();
            final directory = await getApplicationDocumentsDirectory();
            final imagePath = await File('${directory.path}/qr_image.png').create();
            await imagePath.writeAsBytes(pngBytes);
            setState(() {
              _savedFile = imagePath.path;
            });
            print("QR Image saved to ${imagePath.path}");
          } else {
            print('Unable to get byte data from image.');
          }
        } else {
          print('Boundary object is not available for image capture.');
        }
      } catch (e) {
        print(e.toString());
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  child: QrImageView(
                    data: widget.url,
                    version: QrVersions.auto,
                    size: 50.0,
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
              ElevatedButton(
                onPressed: _captureAndSavePNG,
                style: AppButtonStyle.basicButton.copyWith(
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
                  ),
                child: const Text('Сохранить QR-код', style: TextStyle(fontSize: 20)),
              ),
              if (_savedFile.isNotEmpty) Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Сохранено в $_savedFile',),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
