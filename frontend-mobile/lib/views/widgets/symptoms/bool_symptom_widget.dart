import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/utils/constants.dart';
import 'package:flutter/material.dart';

class BoolSymptomWidget extends StatefulWidget {
  final String label;
  final int value;

  const BoolSymptomWidget({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  State<BoolSymptomWidget> createState() => _BoolSymptomWidgetState();
}

class _BoolSymptomWidgetState extends State<BoolSymptomWidget> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    _isSelected = widget.value == 0 ? false : true;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: DeviceScreenConstants.screenWidth * 0.4,
        maxHeight: 65,
      ),
      child: Stack(
        children: [
          AppStyleCard(
            backgroundColor: _isSelected? AppColors.activeColor : Colors.white,
            child: Center(
              child: Text(
                widget.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: _isSelected? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
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
