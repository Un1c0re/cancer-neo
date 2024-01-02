import 'package:diplom/frontend/Theme/app_colors.dart';
import 'package:diplom/frontend/Theme/app_style.dart';
import 'package:diplom/frontend/Theme/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';


class StatsWidget extends StatefulWidget {
  const StatsWidget({super.key});

  @override
  State<StatsWidget> createState() => _StatsWidgetState();
}
class _StatsWidgetState extends State<StatsWidget> {

  final _notesInputController = TextEditingController();
  final notesInputDecoration = AppStyleTextFields.sharedDecoration;
  DateTime selectedDate = DateTime.now();
  
  Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2020),
    lastDate: DateTime(2025),
  );
  if (picked != null && picked != selectedDate) {
    setState(() {
      selectedDate = picked;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 40,
            maxWidth: 150,
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: AppButtonStyle.dateButton,
                  onPressed: () => _selectDate(context),
                  child: const Icon(Icons.calendar_today_outlined),
                ),
              ),
            ],
          ),
        ),
          SizedBox(height: 40),
          GradeSymptom(label: 'Симптом', elIndex: 0,),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ApppStyleChip(label: 'Симптом'),
              ApppStyleChip(label: 'Симптом'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ApppStyleChip(label: 'Симптом'),
              ApppStyleChip(label: 'Симптом'),
            ],
          ),
          SizedBox(height: 20), 
          GradeSymptom(label: 'Симптом', elIndex: 0,),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ApppStyleChip(label: 'Симптом'),
              ApppStyleChip(label: 'Симптом'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ApppStyleChip(label: 'Симптом'),
              ApppStyleChip(label: 'Симптом'),
            ],
          ),
          SizedBox(height: 20), 
          GradeSymptom(label: 'Симптом', elIndex: 0,),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ApppStyleChip(label: 'Симптом'),
              ApppStyleChip(label: 'Симптом'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ApppStyleChip(label: 'Симптом'),
              ApppStyleChip(label: 'Симптом'),
            ],
          ),
          SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 200,
            ),
            child: AppStyleCard(
              backgroundColor: Colors.white, 
              child: Column(
                children: [
                  Text('Ваша заметка', style: TextStyle(fontSize: 20),),
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
              data: const SliderThemeData(
                trackHeight: 10,
                showValueIndicator: ShowValueIndicator.never,
                trackShape: RoundedRectSliderTrackShape(), 
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