import 'package:cancerneo/helpers/get_helpers.dart';
import 'package:cancerneo/services/database_service.dart';
import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/utils/app_style.dart';
import 'package:cancerneo/utils/app_widgets.dart';
import 'package:cancerneo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditSymptomWidget extends StatefulWidget {
  final Function onUpdate;
  final String oldName;
  const EditSymptomWidget({
    super.key,
    required this.onUpdate,
    required this.oldName,
  });

  @override
  State<EditSymptomWidget> createState() => _EditSymptomWidgetState();
}

class _EditSymptomWidgetState extends State<EditSymptomWidget> {
  final _nameInputController = TextEditingController();

  @override
  void initState() {
    _nameInputController.text = widget.oldName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseService service = Get.find();

    final nameInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('название симптома'),
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: DeviceScreenConstants.screenHeight * 0.65,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: DeviceScreenConstants.screenHeight * 0.1),
            child: AppStyleCard(
                backgroundColor: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: nameInputDecoration,
                      cursorColor: AppColors.activeColor,
                      controller: _nameInputController,
                    ),
                  ],
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
                      await service.database.symptomsNamesDao.updateSymptomName(
                          widget.oldName, _nameInputController.text.trim());
                      editAction('Симптом изменен');
                      widget.onUpdate();
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
