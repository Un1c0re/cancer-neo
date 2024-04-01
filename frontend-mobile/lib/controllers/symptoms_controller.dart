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

class BoolSymptomController extends GetxController {
  RxDouble currentValue = RxDouble(0);

  BoolSymptomController(double initialValue) {
    currentValue.value = initialValue;
  }

  void updateBoolValue(double newValue) {
    currentValue.value = newValue;
  }

  Future<void> updateSymptomValueInDB(int id, int value) async {
    final DatabaseService databaseService = Get.find();
    await databaseService.database.symptomsValuesDao.updateSymptomValue(
      symptomValueId: id,
      newValue: value,
    );
  }
}

class NumSymptomController extends GetxController {
  RxDouble currentValue = RxDouble(0);

  NumSymptomController(double initialValue) {
    currentValue.value = initialValue;
  }

  void updateNumValue(double newValue) {
    currentValue.value = newValue;
  }

  Future<void> updateSymptomValueInDB(int id, int value) async {
    final DatabaseService databaseService = Get.find();
    await databaseService.database.symptomsValuesDao.updateSymptomValue(
      symptomValueId: id,
      newValue: value,
    );
  }
}