import 'package:dio/dio.dart';

Future<void> sendDataToServer(Map<String, dynamic> data) async {
  var dio = Dio();
  var url = 'http://10.13.13.70:8000/patient/'; // Замените на URL вашего сервера
  print("MY SENDING DATA________ $data\n\n");
  try {
    var response = await dio.post(url, data: data);

    if (response.statusCode == 200) {
      // Обработка успешного ответа
      print('Data sent successfully');
    } else {
      // Обработка ошибки
      print('Failed to send data');
    }
  } catch (e) {
    // Обработка исключений
    print('Error: $e');
  }
}
