import 'package:diplom/services/database_service.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_style.dart';
import 'package:diplom/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({super.key});

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final _fioInputController         = TextEditingController();
  final _birthDateInputController   = TextEditingController();
  final _diseaseInputController     = TextEditingController();
  final _threatmentInputController  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final DatabaseService databaseService = Get.find();

    Future<void> updateUser(String newName, DateTime newBirthdate,
        String newDiseaseHistory, String newThreatmentHistory) async {
      await databaseService.database.usersDao.updateUser(
        userId: 0,
        name: newName,
        birthdate: newBirthdate,
        diseaseHistory: newDiseaseHistory,
        threatmentHistory: newThreatmentHistory,
      );
    }

    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: DeviceScreenConstants.screenHeight * 0.75,
              child: _DocDataWidget(
                nameController: _fioInputController,
                birthController: _birthDateInputController,
                diseaseController: _diseaseInputController,
                threatmentController: _threatmentInputController,
              ),
            ),
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 150,
                    child: OutlinedButton(
                      style: AppButtonStyle.outlinedRedRoundedButton,
                      onPressed: ()=> Get.back(),
                      child: const Text('Отменить'),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: AppButtonStyle.filledRoundedButton,
                      onPressed: () {
                        updateUser(
                          _fioInputController.text, 
                          DateTime.parse(_birthDateInputController.text), 
                          _diseaseInputController.text, 
                          _threatmentInputController.text,
                        );

                        Get.back();

                        Get.snackbar(
                          'Успешно!',
                          'Документ добавлен',
                          backgroundColor: Colors.tealAccent.withOpacity(0.4),
                          colorText: Colors.teal.shade900,
                          snackPosition: SnackPosition.TOP,
                          duration: const Duration(milliseconds: 1500),
                          animationDuration: const Duration(milliseconds: 500),
                        );
                      },
                      child: const Text('Подтвердить'),
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}

class _DocDataWidget extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController birthController;
  final TextEditingController diseaseController;
  final TextEditingController threatmentController;

  const _DocDataWidget({
    required this.nameController,
    required this.birthController,
    required this.diseaseController,
    required this.threatmentController
  });

  @override
  State<_DocDataWidget> createState() => _DocDataWidgetState();
}

class _DocDataWidgetState extends State<_DocDataWidget> {
  DateTime? _pickedDateTime;

  late TextEditingController nameController;
  late TextEditingController birthController;
  late TextEditingController diseaseController;
  late TextEditingController threatmentController;

  @override
  void initState() {
    _pickedDateTime = DateTime.now();

    nameController = widget.nameController;
    birthController = widget.birthController;
    diseaseController = widget.diseaseController;
    threatmentController = widget.threatmentController;
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _pickedDateTime) {
      setState(() {
        _pickedDateTime = picked;
        birthController.text = _pickedDateTime.toString().substring(0, 10);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('Имя'),
    );

    final birthDateInputDecoration =
        AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('Дата рождения'),
      suffix: IconButton(
        onPressed: () => _selectDate(context),
        icon: const Icon(Icons.calendar_today),
      ),
    );

    final diseaseInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('Заболевание'),
    );

    final phoneInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('Лечение'),
    );

    return AppStyleCard(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const _AddPhotoWidget(),
          TextField(
            decoration: nameInputDecoration,
            cursorColor: AppColors.activeColor,
            controller: nameController,
          ),
          TextField(
            decoration: birthDateInputDecoration,
            cursorColor: AppColors.activeColor,
            controller: birthController,
          ),
          TextField(
            decoration: diseaseInputDecoration,
            cursorColor: AppColors.activeColor,
            controller: diseaseController,
          ),
          TextField(
            decoration: phoneInputDecoration,
            cursorColor: AppColors.activeColor,
            controller: threatmentController,
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }
}

class _AddPhotoWidget extends StatelessWidget {
  const _AddPhotoWidget();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 200,
      height: 150,
      child: SizedBox(
        child: Text('Пожалуйста, внесите ваши данные'),
      ),
    );
  }
}
