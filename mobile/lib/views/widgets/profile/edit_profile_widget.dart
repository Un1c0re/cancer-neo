import 'package:cancerneo/helpers/datetime_helpers.dart';
import 'package:cancerneo/helpers/get_helpers.dart';
import 'package:cancerneo/helpers/validate_helpers.dart';
import 'package:cancerneo/models/user_model.dart';
import 'package:cancerneo/services/database_service.dart';
import 'package:cancerneo/utils/app_widgets.dart';
import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/utils/app_style.dart';
import 'package:cancerneo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileWidget extends StatefulWidget {
  final Function onUpdate;
  const EditProfileWidget({
    super.key, 
    required this.onUpdate,
  });

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final _nameInputController = TextEditingController();
  final _birthDateInputController = TextEditingController();
  final _diseaseInputController = TextEditingController();
  final _threatmentInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late DateTime _pickedDate;
  bool _isDateInitialized = false;

  @override
  Widget build(BuildContext context) {
    final DatabaseService service = Get.find();

    Future<void> updateUser(String newName, DateTime newBirthdate,
        String newDiseaseHistory, String newThreatmentHistory) async {
      await service.database.usersDao.updateUser(
        userId: 0,
        name: newName,
        birthdate: newBirthdate,
        disease: newDiseaseHistory,
        threatment: newThreatmentHistory,
      );
    }

    final nameInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('Имя'),
    );

    final birthDateInputDecoration =
        AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('Дата рожднния'),
      suffix: IconButton(
        onPressed: () async {
          DateTime? newDate = await selectDate(context, _pickedDate);
          if (newDate != null) {
            setState(() {
              _pickedDate = newDate;
              _birthDateInputController.text =
                  customFormat.format(_pickedDate).toString().substring(0, 10);
            });
          }
        },
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
                    if (!_isDateInitialized) {
                      _pickedDate = userdata.birthdate;
                      _isDateInitialized = true;
                    }
                    _birthDateInputController.text =
                        customFormat.format(_pickedDate).toString().substring(0, 10);
                    _diseaseInputController.text = userdata.deseaseHistory;
                    _threatmentInputController.text =
                        userdata.threatmentHistory;

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
                          customFormat.parse(_birthDateInputController.text),
                          _diseaseInputController.text,
                          _threatmentInputController.text,
                        );
                        editAction('Профиль изменен');
                        widget.onUpdate();
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
