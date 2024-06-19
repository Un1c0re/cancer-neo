import 'package:cancerneo/helpers/get_helpers.dart';
import 'package:cancerneo/views/screens/qr-code/qr_code_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<void> uploadFile(String filePath) async {
  String envUrl = dotenv.env['WEB_SERVER_ADDRESS']!;

  var url = Uri.parse(envUrl);
  // Создаем POST запрос
  var request = http.MultipartRequest('POST', url);

  // Добавляем файл как часть многокомпонентного запроса
  request.files.add(await http.MultipartFile.fromPath(
    'file',
    filePath,
  ));

  try {
    // Отправляем запрос
    var streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      var response = await http.Response.fromStream(streamedResponse);

      Get.back();
      submitAction('Документ сформирован и загружен');
      Get.to(() => QrCodeScreen(url: response.body));
    }
  } catch (e) {
    errorAction('Не удалось загрузить документ');
    throw UnsupportedError('Ошибка при отправке: $e');
  }
}
