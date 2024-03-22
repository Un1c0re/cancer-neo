import 'package:diplom/services/database_service.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoolSymptomWidget extends StatefulWidget {
  final int symptomID;
  final String label;
  final int value;

  const BoolSymptomWidget({
    super.key,
    required this.symptomID,
    required this.label,
    required this.value,
  });

  @override
  State<BoolSymptomWidget> createState() => _BoolSymptomWidgetState();
}

class _BoolSymptomWidgetState extends State<BoolSymptomWidget> {
  final DatabaseService databaseService = Get.find();
  bool _isSelected = false;
  Future<void> updateValue(int id, int value) async {
    await databaseService.database.symptomsDao.updateSymptomValue(
      symptomValueId: id,
      newValue: value,
    );
  }

  @override
  Widget build(BuildContext context) {
    int _symptomValue = widget.value;
    _isSelected = _symptomValue == 0 ? false : true;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: DeviceScreenConstants.screenWidth * 0.4,
        maxHeight: 65,
      ),
      child: Stack(
        children: [
          AppStyleCard(
            backgroundColor: _isSelected ? AppColors.activeColor : Colors.white,
            child: Center(
              child: Text(
                widget.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: _isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  if(_symptomValue == 0) {
                    _symptomValue = 1;
                  } else {
                    _symptomValue = 0;
                  }
                  await updateValue(widget.symptomID, _symptomValue);
                  setState(() {
                    _isSelected = !_isSelected;
                  });
                },
                splashColor: AppColors.splashColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
