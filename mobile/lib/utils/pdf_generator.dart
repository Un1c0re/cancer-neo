import 'dart:io';

import 'package:cancerneo/helpers/data_helpers.dart';
import 'package:cancerneo/helpers/datetime_helpers.dart';
import 'package:cancerneo/helpers/loading_dialog_helpers.dart';
import 'package:cancerneo/models/user_model.dart';
import 'package:cancerneo/services/database_service.dart';
import 'package:cancerneo/utils/file_uploader.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

Future<void> generatePDF(BuildContext context, DateTime date) async {
  showLoadingDialog(context, 'Подождите, документ формируется');

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

  Map<int, String> daynotesData = await service.database.dayNotesDao
      .getDayNotesForMonth(monthStart, monthEnd);

  UserModel? userdata = await service.database.usersDao.getUserdata();

  final pdf = pw.Document();
  final directory = await getApplicationDocumentsDirectory();

  final month = getMonthNameNominative(date);
  final dateToDraw = '$month ${date.year}';
  final fileName = 'cancerNEO отчет за $dateToDraw.pdf';
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
        width: 1100,
        height: 1600,
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
        pw.Paragraph(text: '\n'),
        pw.Text(
          'Пациент: ${userdata!.username}',
          style: pw.TextStyle(
            fontSize: 30,
            font: font,
            fontFallback: fallbackFonts,
          ),
        ),
        pw.Text(
          '${customFormat.format(userdata.birthdate)} года рождения',
          style: pw.TextStyle(
            fontSize: 30,
            font: font,
            fontFallback: fallbackFonts,
          ),
        ),
        pw.Text(
          'История болезни: ${userdata.deseaseHistory}',
          style: pw.TextStyle(
            fontSize: 30,
            font: font,
            fontFallback: fallbackFonts,
          ),
        ),
        pw.Text(
          'История лечения: ${userdata.threatmentHistory}',
          style: pw.TextStyle(
            fontSize: 30,
            font: font,
            fontFallback: fallbackFonts,
          ),
        ),
        pw.Paragraph(text: '\n'),
        pw.Text(
          'Данные за $dateToDraw',
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
          'Двухуровневые параметры',
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
            columnWidths: {
              0: const pw.FixedColumnWidth(100.0),
            },
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
        pw.Table(border: pw.TableBorder.all(), columnWidths: {
          0: const pw.FixedColumnWidth(100.0),
        }, children: [
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
                      // pw.BoxDecoration(color: PdfColor.fromHex('#A7FFA6'));
                      pw.BoxDecoration(color: PdfColor.fromHex('#E7E4A6'));
                } else if (idx > 0 &&
                    double.parse(cell).toInt() > 1 &&
                    double.parse(cell).toInt() <= 2) {
                  decoration =
                      // pw.BoxDecoration(color: PdfColor.fromHex('#FFCFA4'));
                      pw.BoxDecoration(color: PdfColor.fromHex('#FFD280'));
                } else if (idx > 0 && double.parse(cell).toInt() >= 3) {
                  decoration =
                      // pw.BoxDecoration(color: PdfColor.fromHex('#FF969D'));
                      pw.BoxDecoration(color: PdfColor.fromHex('#FFAA80'));
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
        pw.Table(border: pw.TableBorder.all(), columnWidths: {
          0: const pw.FixedColumnWidth(100.0),
        }, children: [
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
        pw.Table(border: pw.TableBorder.all(), columnWidths: {
          0: const pw.FixedColumnWidth(100.0),
        }, children: [
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
        pw.Table(border: pw.TableBorder.all(), columnWidths: {
          0: const pw.FixedColumnWidth(100.0),
        }, children: [
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
        pw.Text(
          'Заметки\n',
          style: pw.TextStyle(
            color: PdfColor.fromHex('608CC1'),
            font: font,
            fontSize: 30,
            fontFallback: fallbackFonts,
          ),
        ),
        ...daynotesData.entries.map((entry) {
          return pw.Paragraph(
              text: 'День: ${entry.key}\nЗапись: ${entry.value}\n',
              style: pw.TextStyle(
                font: font,
                fontFallback: fallbackFonts,
                fontSize: 25,
              ));
        }),
      ],
    ),
  );

  // Сохранение документа в файл
  final file = File(filePath);
  await file.writeAsBytes(await pdf.save());

  await uploadFile(filePath);
}
