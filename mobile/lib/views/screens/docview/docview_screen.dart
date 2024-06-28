import 'dart:typed_data';
import 'package:cancerneo/helpers/doc_load_helpers.dart';
import 'package:cancerneo/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// TODO: протестировать на разных форматах изображений, исправить баги

class PdfViewerScreen extends StatelessWidget {
  final Uint8List bytes;

  const PdfViewerScreen({
    super.key,
    required this.bytes,
  });

  @override
  Widget build(BuildContext context) {
    Widget docView;
    if (isPdf(bytes)) {
      docView = SfPdfViewer.memory(bytes);
    } else if (isImage(bytes)) {
      docView = Center(
        child: Image.memory(bytes),
      );
    } else {
      // Добавил обработку случая, когда тип файла неизвестен
      docView = const Center(
        child: Text('Не удалось определить тип файла'),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.activeColor,
        title: const Text(
          'Просмотр документа',
          style: TextStyle(
            fontSize: 26,
          ),
        ),
        centerTitle: true,
      ),
      body: docView,
    );
  }
}