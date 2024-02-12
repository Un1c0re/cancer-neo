import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_style.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/views/screens/symptoms/add_symptom_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SymptomsWidget extends StatefulWidget {
  const SymptomsWidget({super.key});

  @override
  State<SymptomsWidget> createState() => _SymptomsWidgetState();
}

class _SymptomsWidgetState extends State<SymptomsWidget> {
  final _notesInputController = TextEditingController();
  final notesInputDecoration = AppStyleTextFields.sharedDecoration;
  DateTime selectedDate = DateTime.now();

  // Calendar
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      cancelText: 'Отменить',
      confirmText: 'Подтвердить',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.primaryColor, // Цвет выбранной даты
            colorScheme: const ColorScheme.light(
                primary: AppColors.primaryColor), // Цветовая схема
            buttonTheme: const ButtonThemeData(
                textTheme: ButtonTextTheme.primary), // Тема кнопок
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _addSymptom() => Get.to(() => AddSymptomScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          constraints: const BoxConstraints(
            maxWidth: 150,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    foregroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 255, 255, 255)),
                  ),
                  onPressed: () => _selectDate(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_today_outlined),
                      Text(
                        selectedDate.toIso8601String().substring(0, 10),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SymptomsBlock(
                gradeSymptom: 'Симптом',
                boolSymptom1: 'Симптом',
                boolSymptom2: 'Симптом',
                boolSymptom3: 'Симптом',
                boolSymptom4: 'Симптом',
              ),
              const SizedBox(height: 20),
              SymptomsBlock(
                gradeSymptom: 'Симптом',
                boolSymptom1: 'Симптом',
                boolSymptom2: 'Симптом',
                boolSymptom3: 'Симптом',
                boolSymptom4: 'Симптом',
              ),
              const SizedBox(height: 20),
              SymptomsBlock(
                gradeSymptom: 'Симптом',
                boolSymptom1: 'Симптом',
                boolSymptom2: 'Симптом',
                boolSymptom3: 'Симптом',
                boolSymptom4: 'Симптом',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: AppButtonStyle.filledRoundedButton,
                onPressed: _addSymptom,
                child: const Text('Добавить симптом'),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 200,
                ),
                child: AppStyleCard(
                  backgroundColor: Colors.white,
                  child: Column(
                    children: [
                      const Text(
                        'Ваша заметка',
                        style: TextStyle(fontSize: 20),
                      ),
                      TextField(
                        maxLines: 5,
                        decoration: notesInputDecoration,
                        cursorColor: AppColors.activeColor,
                        controller: _notesInputController,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradeSymptom extends StatefulWidget {
  final String label;
  final int elIndex;
  const GradeSymptom({
    super.key,
    required this.label,
    required this.elIndex,
  });

  @override
  State<GradeSymptom> createState() => _GradeSymptomState();
}

class _GradeSymptomState extends State<GradeSymptom> {
  double _currentSliderValue = 0;
  List<String> labels = ['нет', 'слабо', 'средне', 'сильно'];

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 100,
      ),
      child: AppStyleCard(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Text(
              widget.label,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 10,
                showValueIndicator: ShowValueIndicator.never,
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 6,
                  elevation: 0,
                ),
                trackShape: RoundedRectSliderTrackShape(),
                tickMarkShape: CustomTickMarkShape(),
              ),
              child: Slider(
                label: labels[_currentSliderValue.toInt()],
                value: _currentSliderValue,
                max: 3,
                divisions: 3,
                activeColor: ColorTween(
                  begin: AppColors.barColor,
                  end: AppColors.barShadow,
                ).evaluate(AlwaysStoppedAnimation(_currentSliderValue / 4)),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ),
            ),
          ],
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

class SymptomsBlock extends StatelessWidget {
  final String gradeSymptom;
  final String boolSymptom1;
  final String boolSymptom2;
  final String boolSymptom3;
  final String boolSymptom4;

  const SymptomsBlock({
    super.key,
    required this.gradeSymptom,
    required this.boolSymptom1,
    required this.boolSymptom2,
    required this.boolSymptom3,
    required this.boolSymptom4,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GradeSymptom(
          label: gradeSymptom,
          elIndex: 0,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ApppStyleChip(label: boolSymptom1),
            ApppStyleChip(label: boolSymptom2),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ApppStyleChip(label: boolSymptom3),
            ApppStyleChip(label: boolSymptom4),
          ],
        ),
      ],
    );
  }
}
