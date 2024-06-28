import 'dart:io';
import 'package:cancerneo/helpers/doc_load_helpers.dart';
import 'package:cancerneo/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  final String filePath;

  const PdfViewerScreen({
    super.key,
    required this.filePath,
  });

@override
  Widget build(BuildContext context) {
    Widget docView;

    // Проверка существования файла
    if (!File(filePath).existsSync()) {
      docView = const Center(
        child: Text('Файл не найден'),
      );
    } else if (isPdf(filePath)) {
      docView = SfPdfViewer.file(File(filePath));
    } else if (isImage(filePath)) {
      try {
        docView = Center(
          child: Image.file(File(filePath)),
        );
      } catch (e) {
        docView = Center(
          child: Text('Ошибка при загрузке изображения: $e'),
        );
      }
    } else {
      // Обработка неизвестного типа файла
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
