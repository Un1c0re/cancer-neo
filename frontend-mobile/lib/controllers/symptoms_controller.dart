import 'package:diplom/services/database_service.dart';
import 'package:get/get.dart';

class GradeSymptomController extends GetxController {
  RxDouble currentSliderValue = 0.0.obs;

  GradeSymptomController(double initialValue) {
    currentSliderValue.value = initialValue;
  }

  void updateSliderValue(double newValue) {
    currentSliderValue.value = newValue;
  }

  Future<void> updateSymptomValueInDB(int id, int value) async {
    final DatabaseService databaseService = Get.find();
    await databaseService.database.symptomsValuesDao.updateSymptomValue(
      symptomValueId: id,
      newValue: value,
    );
  }
}
