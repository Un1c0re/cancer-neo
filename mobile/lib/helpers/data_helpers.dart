import 'package:diplom/services/database_service.dart';
import 'package:get/get.dart';

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