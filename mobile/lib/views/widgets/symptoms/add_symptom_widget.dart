import 'package:diplom/helpers/get_helpers.dart';
import 'package:diplom/helpers/validate_helpers.dart';
import 'package:diplom/services/database_service.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_style.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSymptomWidget extends StatefulWidget {
  final Function onUpdate;
  const AddSymptomWidget({super.key, required this.onUpdate});

  @override
  State<AddSymptomWidget> createState() => _AddSymptomWidgetState();
}

class _AddSymptomWidgetState extends State<AddSymptomWidget> {
  final _nameInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final DatabaseService service = Get.find();

    final nameInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('название симптома'),
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: DeviceScreenConstants.screenHeight*0.65,),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: DeviceScreenConstants.screenHeight * 0.1),
            child: AppStyleCard(
                backgroundColor: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: nameInputDecoration,
                        cursorColor: AppColors.activeColor,
                        controller: _nameInputController,
                        validator: validateString,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ],
                  ),
                )),
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
                      if(_formKey.currentState!.validate()) {
                        await service.database.symptomsNamesDao.addSymptomName(
                        _nameInputController.text.trim()
                      );
                      await service.database.symptomsValuesDao.addSymptomValue(
                        date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                        symptomName: _nameInputController.text.trim(),
                        value: 0
                      );
                      submitAction('Симптом добален');
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