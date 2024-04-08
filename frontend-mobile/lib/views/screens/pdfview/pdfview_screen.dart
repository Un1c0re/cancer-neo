import 'dart:typed_data';
import 'package:diplom/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  final Uint8List pdfBytes;

  const PdfViewerScreen({
    super.key, 
    required this.pdfBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.activeColor,
        title: const Text('Просмотр документа'),
        centerTitle: true,
      ),
      body: SfPdfViewer.memory(pdfBytes),
    );
  }
}
