import 'dart:io';
import 'package:diplom/helpers/get_helpers.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

Future<void> generatePdfWithTable() async {
  final pdf = pw.Document();
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/cancer-neo-file.pdf';
  final List<String> tableHeader = [];

  tableHeader.add('Симптом');
  for (int i = 0; i < 31; i ++) {
    tableHeader.add(i.toString());
  }


  pdf.addPage(
    pw.MultiPage(
      build: (context) => [
        Text(
          'CancerNEO - мобильный ассистент пациента',
          style: TextStyle(
            fontSize: 20,
            color: PdfColor.fromHex('608CC1')
          ),
        ),
        pw.TableHelper.fromTextArray(
          cellAlignment: Alignment.center,
          context: context,
          data: <List<String>>[
            tableHeader,
            // Добавьте больше данных здесь
          ],
        ),
      ],
    ),
  );

  // Сохранение документа в файл
  final file = File(filePath);
  await file.writeAsBytes(await pdf.save());

  // Открытие файла во внешнем приложении (если это требуется)
  await Printing.sharePdf(bytes: await pdf.save(), filename: 'cancer-neo-file.pdf');
  submitAction('Документ сохранен');
}