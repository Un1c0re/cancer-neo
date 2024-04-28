import 'dart:io';
import 'package:diplom/helpers/datetime_helpers.dart';
import 'package:diplom/helpers/get_helpers.dart';
import 'package:diplom/services/database_service.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

Future<List<List<String>>> getSymptomsDataList(
    List<List<double>> data, int typeID) async {
  final DatabaseService service = Get.find();

  final List<String> nameList =
      await service.database.symptomsNamesDao.getSymptomsNamesByTypeID(typeID);

  List<List<String>> result = [];

  // Проходим по каждому индексу ключей
  for (int i = 0; i < nameList.length; i++) {
    // Собираем элементы по текущему индексу из каждого подсписка
    List<String> column = [];
    column.add(nameList[i]);
    for (int j = 0; j < data.length; j++) {
      if (data[j].isEmpty) {
        column.add('0');
      } else {
        column.add(data[j][i].toString());
      }
    }
    // data.map((list) => column.add(list[i].toString()));
    // Присваиваем собранные элементы соответствующему ключу
    result.add(column);
    column;
  }

  return result;
}

Future<void> generatePdfWithTable(DateTime date) async {
  final DatabaseService service = Get.find();

  final DateTime monthStart = DateTime(date.year, date.month, 1);
  final DateTime monthEnd = DateTime(date.year, date.month + 1, 1);

  List<List<double>> boolMonthData = await service.database.symptomsValuesDao
      .getSymptomsSortedByDayAndNameID(1, monthStart, monthEnd);

  List<List<double>> gradeMonthData = await service.database.symptomsValuesDao
      .getSymptomsSortedByDayAndNameID(2, monthStart, monthEnd);

  List<List<double>> numericMonthData = await service.database.symptomsValuesDao
      .getSymptomsSortedByDayAndNameID(3, monthStart, monthEnd);

  List<List<double>> markerMonthData = await service.database.symptomsValuesDao
      .getSymptomsSortedByDayAndNameID(4, monthStart, monthEnd);

  List<List<double>> customMonthData = await service.database.symptomsValuesDao
      .getSymptomsSortedByDayAndNameID(5, monthStart, monthEnd);

  List<List<String>> boolSymptomsData =
      await getSymptomsDataList(boolMonthData, 1);

  List<List<String>> gradeSymptomsData =
      await getSymptomsDataList(gradeMonthData, 2);

  List<List<String>> numericSymptomsData =
      await getSymptomsDataList(numericMonthData, 3);

  List<List<String>> markerSymptomsData =
      await getSymptomsDataList(markerMonthData, 4);

  List<List<String>> customSymptomsData =
      await getSymptomsDataList(customMonthData, 5);

  final pdf = pw.Document();
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/cancer-neo-file.pdf';
  final font = await PdfGoogleFonts.jostRegular();
  final fontBold = await PdfGoogleFonts.jostSemiBold();
  final List<Font> fallbackFonts = [await PdfGoogleFonts.robotoRegular()];
  final List<String> tableHeader = [];

  tableHeader.add('Симптом');
  for (int i = 1; i < 31; i++) {
    tableHeader.add(i.toString());
  }

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4.copyWith(
        width: 1000,
        height: 1500,
      ),
      build: (context) => [
        Text(
          'CancerNEO - мобильный ассистент пациента',
          style: TextStyle(
            fontSize: 30,
            fontBold: fontBold,
            color: PdfColor.fromHex('608CC1'),
            font: font,
            fontFallback: fallbackFonts,
          ),
        ),
        Text(
          'Данные за ${customFormat.format(date)}',
          style: TextStyle(
            fontSize: 30,
            fontBold: fontBold,
            color: PdfColor.fromHex('608CC1'),
            font: font,
            fontFallback: fallbackFonts,
          ),
        ),
        Text(
          'двухуровневые параметры',
          style: TextStyle(
            color: PdfColor.fromHex('608CC1'),
            fontSize: 20,
            font: font,
            fontFallback: fallbackFonts,
          ),
        ),
        pw.Table(border: pw.TableBorder.all(), children: [
          pw.TableRow(
            decoration: pw.BoxDecoration(color: PdfColor.fromHex('#e8e8e8')),
            children: tableHeader
                .map((header) => pw.Text(header,
                    style: pw.TextStyle(
                      font: font,
                      fontFallback: fallbackFonts,
                    )))
                .toList(),
          ),
          ...boolSymptomsData.map(
            (row) => pw.TableRow(
              children: row.asMap().entries.map((entry) {
                final idx = entry.key;
                final cell = entry.value;
                pw.BoxDecoration decoration;

                if (idx == 0) {
                  decoration =
                      pw.BoxDecoration(color: PdfColor.fromHex('#e8e8e8'));
                } else if (idx > 0 && double.parse(cell).toInt() == 1) {
                  // Условие для другого стиля
                  decoration =
                      pw.BoxDecoration(color: PdfColor.fromHex('#D66BB5'));
                } else {
                  decoration =
                      pw.BoxDecoration(color: PdfColor.fromHex('#fff'));
                }

                return pw.Container(
                  decoration: decoration,
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(
                    cell,
                    style: TextStyle(
                      font: font,
                      fontFallback: fallbackFonts,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ]),
        Text(
          'Условные параметры',
          style: TextStyle(
            color: PdfColor.fromHex('608CC1'),
            font: font,
            fontSize: 20,
            fontFallback: fallbackFonts,
          ),
        ),
        pw.Table(border: pw.TableBorder.all(), children: [
          pw.TableRow(
            decoration: pw.BoxDecoration(color: PdfColor.fromHex('#e8e8e8')),
            children: tableHeader
                .map((header) => pw.Text(header,
                    style: pw.TextStyle(
                      font: font,
                      fontFallback: fallbackFonts,
                    )))
                .toList(),
          ),
          ...gradeSymptomsData.map(
            (row) => pw.TableRow(
              children: row.asMap().entries.map((entry) {
                final idx = entry.key;
                final cell = entry.value;
                pw.BoxDecoration decoration;

                if (idx == 0) {
                  decoration =
                      pw.BoxDecoration(color: PdfColor.fromHex('#e8e8e8'));
                } else if (idx > 0 &&
                    double.parse(cell).toInt() > 0 &&
                    double.parse(cell).toInt() <= 1) {
                  decoration =
                      pw.BoxDecoration(color: PdfColor.fromHex('#57E672'));
                } else if (idx > 0 &&
                    double.parse(cell).toInt() > 1 &&
                    double.parse(cell).toInt() <= 2) {
                  decoration =
                      pw.BoxDecoration(color: PdfColor.fromHex('#D6B06B'));
                } else if (idx > 0 && double.parse(cell).toInt() >= 3) {
                  decoration =
                      pw.BoxDecoration(color: PdfColor.fromHex('#E6576F'));
                } else {
                  decoration = const pw.BoxDecoration(color: PdfColors.white);
                }

                return pw.Container(
                  decoration: decoration,
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(
                    cell,
                    style: TextStyle(
                      font: font,
                      fontFallback: fallbackFonts,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ]),
        Text(
          'Численные параметры',
          style: TextStyle(
            color: PdfColor.fromHex('608CC1'),
            font: font,
            fontSize: 20,
            fontFallback: fallbackFonts,
          ),
        ),
        pw.Table(border: pw.TableBorder.all(), children: [
          pw.TableRow(
            decoration: pw.BoxDecoration(color: PdfColor.fromHex('#e8e8e8')),
            children: tableHeader
                .map((header) => pw.Text(header,
                    style: pw.TextStyle(
                      font: font,
                      fontFallback: fallbackFonts,
                    )))
                .toList(),
          ),
          ...numericSymptomsData.map(
            (row) => pw.TableRow(
              children: row.asMap().entries.map((entry) {
                final idx = entry.key;
                final cell = entry.value;

                return pw.Container(
                  color:
                      idx == 0 ? PdfColor.fromHex('#e8e8e8') : PdfColors.white,
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(
                    cell,
                    style: TextStyle(
                      font: font,
                      fontFallback: fallbackFonts,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ]),
        Text(
          'Маркеры',
          style: TextStyle(
            color: PdfColor.fromHex('608CC1'),
            font: font,
            fontSize: 20,
            fontFallback: fallbackFonts,
          ),
        ),
        pw.Table(border: pw.TableBorder.all(), children: [
          pw.TableRow(
            decoration: pw.BoxDecoration(color: PdfColor.fromHex('#e8e8e8')),
            children: tableHeader
                .map((header) => pw.Text(header,
                    style: pw.TextStyle(
                      font: font,
                      fontFallback: fallbackFonts,
                    )))
                .toList(),
          ),
          ...markerSymptomsData.map(
            (row) => pw.TableRow(
              children: row.asMap().entries.map((entry) {
                final idx = entry.key;
                final cell = entry.value;

                return pw.Container(
                  color:
                      idx == 0 ? PdfColor.fromHex('#e8e8e8') : PdfColors.white,
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(
                    cell,
                    style: pw.TextStyle(
                      color: idx == 0
                          ? PdfColors.black
                          : PdfColor.fromHex('#7F6BD6'),
                      font: font,
                      fontFallback: fallbackFonts,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ]),
        Text(
          'Пользовательские параметры',
          style: TextStyle(
            color: PdfColor.fromHex('608CC1'),
            font: font,
            fontSize: 20,
            fontFallback: fallbackFonts,
          ),
        ),
        pw.Table(border: pw.TableBorder.all(), children: [
          pw.TableRow(
            decoration: pw.BoxDecoration(color: PdfColor.fromHex('#e8e8e8')),
            children: tableHeader
                .map((header) => pw.Text(header,
                    style: pw.TextStyle(
                      font: font,
                      fontFallback: fallbackFonts,
                    )))
                .toList(),
          ),
          ...customSymptomsData.map(
            (row) => pw.TableRow(
              children: row.asMap().entries.map((entry) {
                final idx = entry.key;
                final cell = entry.value;

                return pw.Container(
                  color:
                      idx == 0 ? PdfColor.fromHex('#e8e8e8') : PdfColors.white,
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(
                    cell,
                    style: pw.TextStyle(
                      color: idx == 0
                          ? PdfColors.black
                          : PdfColor.fromHex('#5770E6'),
                      font: font,
                      fontFallback: fallbackFonts,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ]),
      ],
    ),
  );

  // Сохранение документа в файл
  final file = File(filePath);
  await file.writeAsBytes(await pdf.save());

  // Открытие файла во внешнем приложении (если это требуется)
  await Printing.sharePdf(
      bytes: await pdf.save(), filename: 'cancer-neo-file.pdf');
  submitAction('Документ сохранен');
}
