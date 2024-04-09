import 'package:diplom/helpers/get_helpers.dart';
import 'package:diplom/helpers/validate_helpers.dart';
import 'package:diplom/models/user_model.dart';
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
  final _nameInputController = TextEditingController();
  final _birthDateInputController = TextEditingController();
  final _diseaseInputController = TextEditingController();
  final _threatmentInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DateTime? _pickedDateTime;

  @override
  void initState() {
    _pickedDateTime = DateTime.now();
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
    final DatabaseService service = Get.find();

    Future<void> updateUser(String newName, DateTime newBirthdate,
        String newDiseaseHistory, String newThreatmentHistory) async {
      await service.database.usersDao.updateUser(
        userId: 0,
        name: newName,
        birthdate: newBirthdate,
        diseaseHistory: newDiseaseHistory,
        threatmentHistory: newThreatmentHistory,
      );
    }

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

    Future<UserModel?> getUser() async {
      return await service.database.usersDao.getUserdata();
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: DeviceScreenConstants.screenHeight * 0.75,
            child: AppStyleCard(
              backgroundColor: Colors.white,
              child: FutureBuilder(
                future: getUser(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final UserModel userdata = snapshot.data!;

                    _nameInputController.text = userdata.username;
                    _birthDateInputController.text =
                        userdata.birthdate.toIso8601String().substring(0, 10);
                    _diseaseInputController.text = userdata.deseaseHistory;
                    _threatmentInputController.text = userdata.threatmentHistory;

                    return Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextFormField(
                            decoration: nameInputDecoration,
                            cursorColor: AppColors.activeColor,
                            controller: _nameInputController,
                            validator: validateName,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          TextFormField(
                            decoration: birthDateInputDecoration,
                            cursorColor: AppColors.activeColor,
                            controller: _birthDateInputController,
                            validator: validateDate,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          TextFormField(
                            decoration: diseaseInputDecoration,
                            cursorColor: AppColors.activeColor,
                            controller: _diseaseInputController,
                            maxLines: 5,
                          ),
                          TextFormField(
                            decoration: threatmentInputDecoration,
                            cursorColor: AppColors.activeColor,
                            controller: _threatmentInputController,
                            maxLines: 5,
                          ),
                        ],
                      ),
                    );
                  }
                }),
              ),
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
                    onPressed: cancelAction,
                    child: const Text('Отменить'),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: AppButtonStyle.filledRoundedButton,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await updateUser(
                          _nameInputController.text,
                          DateTime.parse(_birthDateInputController.text),
                          _diseaseInputController.text,
                          _threatmentInputController.text,
                        );
                        editAction('Профиль изменен');
                      }
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
