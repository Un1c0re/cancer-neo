import 'package:diplom/frontend/Theme/app_colors.dart';
import 'package:diplom/frontend/Theme/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../backend/features/build_data.dart';
import '../../../backend/requests/post_patient.dart';
import '../../Theme/app_style.dart';
import '../../Theme/constants.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({super.key});

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  void _cancel() => Get.back();

  final _fioInputController = TextEditingController();
  final _birthDateInputController = TextEditingController();
  final _diseaseInputController = TextEditingController();
  final _phoneInputController = TextEditingController();

  void _submit() {
      Map<String, dynamic> data = buildDataJson(
      _fioInputController,
      _birthDateInputController,
      _diseaseInputController,
      _phoneInputController,
    );

    sendDataToServer(data);

    Get.back();

    Get.snackbar(
      'Успешно!',
      'Данные профиля обновлены',
      backgroundColor: Colors.tealAccent.withOpacity(0.4),
      colorText: Colors.teal.shade900,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(milliseconds: 1500),
      animationDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                phoneController: _phoneInputController,
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
                      onPressed: _cancel,
                      child: const Text('Отменить'),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: AppButtonStyle.filledRoundedButton,
                      onPressed: _submit,
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
  final TextEditingController phoneController;

  const _DocDataWidget(
      {super.key,
      required this.nameController,
      required this.birthController,
      required this.diseaseController,
      required this.phoneController});

  @override
  State<_DocDataWidget> createState() => _DocDataWidgetState();
}

class _DocDataWidgetState extends State<_DocDataWidget> {
  DateTime? _pickedDateTime;

  late TextEditingController nameController;
  late TextEditingController birthController;
  late TextEditingController diseaseController;
  late TextEditingController phoneController;

  @override
  void initState() {
    _pickedDateTime = DateTime.now();

    nameController    = widget.nameController;
    birthController   = widget.birthController;
    diseaseController = widget.diseaseController;
    phoneController   = widget.phoneController;
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
        birthController.text =
            _pickedDateTime.toString().substring(0, 10);
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
      label: const Text('Телефон'),
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
            controller: phoneController,
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }
}

class _AddPhotoWidget extends StatelessWidget {
  const _AddPhotoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      child: const SizedBox(
        child: Text('Пожалуйста, внесите ваши данные'),
        ),
      );
  }
}
