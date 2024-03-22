import 'package:diplom/services/database_service.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GradeSymptomWidget extends StatefulWidget {
  final int symptomID;
  final String label;
  final int symptomCurrentValue;
  final Function onUpdate;

  const GradeSymptomWidget({
    super.key,
    required this.symptomID,
    required this.symptomCurrentValue, 
    required this.label, 
    required this.onUpdate,
  });

  @override
  State<GradeSymptomWidget> createState() => _GradeSymptomWidgetState();
}

class _GradeSymptomWidgetState extends State<GradeSymptomWidget> {
  List<String> labels = ['нет', 'слабо', 'средне', 'сильно'];

  @override
  Widget build(BuildContext context) {
    double currentSliderValue = widget.symptomCurrentValue.toDouble();
    final DatabaseService databaseService = Get.find();
    
    Future<void> updateValue(int id, int value) async {
      await databaseService.database.symptomsDao.updateSymptomValue(
        symptomValueId: id,
        newValue: value,
        );
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 100,
      ),
      child: AppStyleCard(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.label,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 10,
                  inactiveTrackColor: Color.fromARGB(40, 109, 109, 109),
                  showValueIndicator: ShowValueIndicator.never,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 6,
                    elevation: 0,
                  ),
                  overlayShape: SliderComponentShape.noOverlay,
                  trackShape: const RoundedRectSliderTrackShape(),
                  tickMarkShape: CustomTickMarkShape(),
                ),
                child: Slider(
                  label: labels[currentSliderValue.toInt()],
                  value: currentSliderValue,
                  max: 3,
                  divisions: 3,
                  activeColor: ColorTween(
                    begin: AppColors.barColor,
                    end: AppColors.barShadow,
                  ).evaluate(AlwaysStoppedAnimation(currentSliderValue / 4)),
                  onChanged: (double value) async {
                    setState(() {
                      currentSliderValue = value;
                    });
                    await updateValue(widget.symptomID, value.toInt());
                    widget.onUpdate();
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: labels.map((text) {
                  return Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTickMarkShape extends SliderTickMarkShape {
  @override
  Size getPreferredSize({
    required SliderThemeData sliderTheme,
    required bool isEnabled,
  }) {
    // Вы можете изменить размеры, если это необходимо
    return Size.zero; // Size.zero означает, что фигура не будет отображаться
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    bool isEnabled = false,
    TextDirection textDirection = TextDirection.ltr,
  }) {
    // Ничего не рисуем, так как мы хотим, чтобы деления были невидимы
  }
}
