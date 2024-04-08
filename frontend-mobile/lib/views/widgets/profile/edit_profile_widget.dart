import 'package:diplom/helpers/get_helpers.dart';
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
  final _fioInputController = TextEditingController();
  final _birthDateInputController = TextEditingController();
  final _diseaseInputController = TextEditingController();
  final _threatmentInputController = TextEditingController();

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
                    onPressed: () => cancelAction,
                    child: const Text('Отменить'),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: AppButtonStyle.filledRoundedButton,
                    onPressed: () async {
                      await updateUser(
                        _fioInputController.text,
                        DateTime.parse(_birthDateInputController.text),
                        _diseaseInputController.text,
                        _threatmentInputController.text,
                      );
                      editAction('Профиль изменен');
                    },
                    child: const Text('Подтвердить'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DocDataWidget extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController birthController;
  final TextEditingController diseaseController;
  final TextEditingController threatmentController;

  const _DocDataWidget(
      {required this.nameController,
      required this.birthController,
      required this.diseaseController,
      required this.threatmentController});

  @override
  State<_DocDataWidget> createState() => _DocDataWidgetState();
}

class _DocDataWidgetState extends State<_DocDataWidget> {
  DateTime? _pickedDateTime;

  late TextEditingController nameController;
  late TextEditingController birthController;
  late TextEditingController diseaseController;
  late TextEditingController threatmentInputController;

  @override
  void initState() {
    _pickedDateTime = DateTime.now();

    nameController = widget.nameController;
    birthController = widget.birthController;
    diseaseController = widget.diseaseController;
    threatmentInputController = widget.threatmentController;
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      locale: const Locale('ru', 'RU'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      cancelText: 'Отменить',
      confirmText: 'Подтвердить',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.primaryColor,
            colorScheme:
                const ColorScheme.light(primary: AppColors.primaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _pickedDateTime) {
      setState(() {
        _pickedDateTime = picked;
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
      label: const Text('Дата рожднния'),
      suffix: IconButton(
        onPressed: () => _selectDate(context),
        icon: const Icon(Icons.calendar_today),
      ),
    );

    final diseaseInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('Заболевание'),
    );

    final threatmentInputDecoration =
        AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('Лечение'),
    );

    return AppStyleCard(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
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
            maxLines: 5,
          ),
          TextField(
            decoration: threatmentInputDecoration,
            cursorColor: AppColors.activeColor,
            controller: threatmentInputController,
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
