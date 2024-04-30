import 'dart:io';
import 'dart:ui';
import 'package:diplom/helpers/data_helpers.dart';
import 'package:diplom/helpers/get_helpers.dart';
import 'package:diplom/services/database_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

Future<List<List<String>>> getIntSymptomsDataList(
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
        column.add((data[j][i].toInt()).toString());
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

  List<List<String>> boolSymptomsData = await getIntSymptomsDataList(
      await service.database.symptomsValuesDao
          .getSymptomsSortedByDayAndNameID(1, monthStart, monthEnd),
      1);

  List<List<String>> gradeSymptomsData = await getIntSymptomsDataList(
      await service.database.symptomsValuesDao
          .getSymptomsSortedByDayAndNameID(2, monthStart, monthEnd),
      2);

  List<List<String>> numericSymptomsData = await getSymptomsDataList(
      await service.database.symptomsValuesDao
          .getSymptomsSortedByDayAndNameID(3, monthStart, monthEnd),
      3);

  List<List<String>> markerSymptomsData = await getSymptomsDataList(
      await service.database.symptomsValuesDao
          .getSymptomsSortedByDayAndNameID(4, monthStart, monthEnd),
      4);

  List<List<String>> customSymptomsData = await getSymptomsDataList(
      await service.database.symptomsValuesDao
          .getSymptomsSortedByDayAndNameID(5, monthStart, monthEnd),
      5);

  // Map<int, String> daynotesData = await service.database.dayNotesDao
  //     .getDayNotesForMonth(monthStart, monthEnd);

  final pdf = pw.Document();
  final directory = await getApplicationDocumentsDirectory();
  final formattedDate =
      DateFormat('MMM y', const Locale('ru', 'RU').toString()).format(date);
  final fileName = 'cancerNEO отчет за $formattedDate.pdf';
  // final fileName = 'cancerNEO.pdf';
  final filePath = '${directory.path}/$fileName';

  final font = await PdfGoogleFonts.jostRegular();
  final fontBold = await PdfGoogleFonts.jostSemiBold();
  final List<pw.Font> fallbackFonts = [await PdfGoogleFonts.robotoRegular()];
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
        pw.Text(
          'CancerNEO - мобильный ассистент пациента',
          style: pw.TextStyle(
            fontSize: 30,
            fontBold: fontBold,
            color: PdfColor.fromHex('608CC1'),
            font: font,
            fontFallback: fallbackFonts,
          ),
        ),
        pw.Text(
          'Данные за $formattedDate',
          style: pw.TextStyle(
            fontSize: 30,
            fontBold: fontBold,
            color: PdfColor.fromHex('608CC1'),
            font: font,
            fontFallback: fallbackFonts,
          ),
        ),
        pw.Paragraph(text: '\n'),
        pw.Text(
          'двухуровневые параметры',
          style: pw.TextStyle(
            color: PdfColor.fromHex('608CC1'),
            fontSize: 25,
            font: font,
            fontFallback: fallbackFonts,
          ),
        ),
        pw.Table(
            border: pw.TableBorder.all(),
            defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
            children: [
              pw.TableRow(
                decoration:
                    pw.BoxDecoration(color: PdfColor.fromHex('#e8e8e8')),
                children: tableHeader
                    .map(
                      (header) => pw.Text(
                        header,
                        style: pw.TextStyle(
                          font: font,
                          fontFallback: fallbackFonts,
                        ),
                        textAlign: pw.TextAlign.center,
                      ),
                    )
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
                          pw.BoxDecoration(color: PdfColor.fromHex('#FFB2BC'));
                      // pw.BoxDecoration(color: PdfColor.fromHex('#FF808A'));
                    } else {
                      decoration =
                          pw.BoxDecoration(color: PdfColor.fromHex('#fff'));
                    }

                    return pw.Container(
                      alignment: idx == 0
                          ? pw.Alignment.centerLeft
                          : pw.Alignment.center,
                      decoration: decoration,
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        cell,
                        style: pw.TextStyle(
                          font: font,
                          fontFallback: fallbackFonts,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ]),
        pw.Paragraph(text: '\n'),
        pw.Text(
          'Условные параметры',
          style: pw.TextStyle(
            color: PdfColor.fromHex('608CC1'),
            font: font,
            fontSize: 25,
            fontFallback: fallbackFonts,
          ),
        ),
        pw.Table(border: pw.TableBorder.all(), children: [
          pw.TableRow(
            decoration: pw.BoxDecoration(color: PdfColor.fromHex('#e8e8e8')),
            children: tableHeader
                .map(
                  (header) => pw.Text(
                    header,
                    style: pw.TextStyle(
                      font: font,
                      fontFallback: fallbackFonts,
                    ),
                    textAlign: pw.TextAlign.center,
                  ),
                )
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
                      pw.BoxDecoration(color: PdfColor.fromHex('#A7FFA6'));
                } else if (idx > 0 &&
                    double.parse(cell).toInt() > 1 &&
                    double.parse(cell).toInt() <= 2) {
                  decoration =
                      pw.BoxDecoration(color: PdfColor.fromHex('#FFCFA4'));
                } else if (idx > 0 && double.parse(cell).toInt() >= 3) {
                  decoration =
                      pw.BoxDecoration(color: PdfColor.fromHex('#FF969D'));
                } else {
                  decoration = const pw.BoxDecoration(color: PdfColors.white);
                }

                return pw.Container(
                  alignment:
                      idx == 0 ? pw.Alignment.centerLeft : pw.Alignment.center,
                  decoration: decoration,
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(
                    cell,
                    style: pw.TextStyle(
                      font: font,
                      fontFallback: fallbackFonts,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ]),
        pw.Paragraph(text: '\n'),
        pw.Text(
          'Численные параметры',
          style: pw.TextStyle(
            color: PdfColor.fromHex('608CC1'),
            font: font,
            fontSize: 25,
            fontFallback: fallbackFonts,
          ),
        ),
        pw.Table(border: pw.TableBorder.all(), children: [
          pw.TableRow(
            decoration: pw.BoxDecoration(color: PdfColor.fromHex('#e8e8e8')),
            children: tableHeader
                .map(
                  (header) => pw.Text(
                    header,
                    style: pw.TextStyle(
                      font: font,
                      fontFallback: fallbackFonts,
                    ),
                    textAlign: pw.TextAlign.center,
                  ),
                )
                .toList(),
          ),
          ...numericSymptomsData.map(
            (row) => pw.TableRow(
              children: row.asMap().entries.map((entry) {
                final idx = entry.key;
                final cell = entry.value;

                return pw.Container(
                  alignment:
                      idx == 0 ? pw.Alignment.centerLeft : pw.Alignment.center,
                  color:
                      idx == 0 ? PdfColor.fromHex('#e8e8e8') : PdfColors.white,
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(
                    cell,
                    style: pw.TextStyle(
                      font: font,
                      fontFallback: fallbackFonts,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ]),
        pw.Paragraph(text: '\n'),
        pw.Text(
          'Маркеры',
          style: pw.TextStyle(
            color: PdfColor.fromHex('608CC1'),
            font: font,
            fontSize: 25,
            fontFallback: fallbackFonts,
          ),
        ),
        pw.Table(border: pw.TableBorder.all(), children: [
          pw.TableRow(
            decoration: pw.BoxDecoration(color: PdfColor.fromHex('#e8e8e8')),
            children: tableHeader
                .map(
                  (header) => pw.Text(
                    header,
                    style: pw.TextStyle(
                      font: font,
                      fontFallback: fallbackFonts,
                    ),
                    textAlign: pw.TextAlign.center,
                  ),
                )
                .toList(),
          ),
          ...markerSymptomsData.map(
            (row) => pw.TableRow(
              children: row.asMap().entries.map((entry) {
                final idx = entry.key;
                final cell = entry.value;

                return pw.Container(
                  alignment:
                      idx == 0 ? pw.Alignment.centerLeft : pw.Alignment.center,
                  color:
                      idx == 0 ? PdfColor.fromHex('#e8e8e8') : PdfColors.white,
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(
                    cell,
                    style: pw.TextStyle(
                      font: font,
                      fontFallback: fallbackFonts,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ]),
        pw.Paragraph(text: '\n'),
        pw.Text(
          'Пользовательские параметры',
          style: pw.TextStyle(
            color: PdfColor.fromHex('608CC1'),
            font: font,
            fontSize: 25,
            fontFallback: fallbackFonts,
          ),
        ),
        pw.Table(border: pw.TableBorder.all(), children: [
          pw.TableRow(
            decoration: pw.BoxDecoration(color: PdfColor.fromHex('#e8e8e8')),
            children: tableHeader
                .map(
                  (header) => pw.Text(
                    header,
                    style: pw.TextStyle(
                      font: font,
                      fontFallback: fallbackFonts,
                    ),
                    textAlign: pw.TextAlign.center,
                  ),
                )
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
                      font: font,
                      fontFallback: fallbackFonts,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ]),
        pw.Paragraph(text: '\n'),
      ],
    ),
  );

  // Сохранение документа в файл
  final file = File(filePath);
  await file.writeAsBytes(await pdf.save());

  // Открытие файла во внешнем приложении (если это требуется)
  await Printing.sharePdf(bytes: await pdf.save(), filename: fileName);
  submitAction('Документ сохранен');
}
