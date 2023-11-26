import 'package:dio/dio.dart';

void sendSymptomsDataToServer(List<Map<String, dynamic>> symptomsList) async {
  var dio = Dio();
  var url = 'http://10.13.13.70:8000/symptoms/'; // Замените на URL вашего сервера
  print("LIST ---- $symptomsList");
  try {
    Response response = await dio.post(url, data: symptomsList);

    if (response.statusCode == 200) {
      print('Данные успешно отправлены на сервер');
    } else {
      print('Ошибка при отправке данных на сервер');
    }
  } catch (e) {
    print('Произошла ошибка: $e');
  }
}
