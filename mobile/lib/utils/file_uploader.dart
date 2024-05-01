import 'package:cancerneo/views/screens/qr-code/qr_code_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<void> uploadFile(String filePath) async {
  var uri = Uri.parse('https://transfer.adttemp.com.br/');

  // Создаем POST запрос
  var request = http.MultipartRequest('POST', uri);

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
      Get.to(() => QrCodeScreen(url: response.body));
    }
  } catch (e) {
    throw UnsupportedError('Ошибка при отправке: $e');
  }
}
