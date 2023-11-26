import 'dart:math';

import 'package:diplom/backend/requests/post_symptoms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Theme/app_style.dart';

class SymptomsData {
  static List<Map<String, dynamic>> symptoms = [
    {
      'name': 'headache',
      'date': '2023-11-26',
      'owner_id': 'user123',
      'strength': 10,
      'is_bool': false
    },
    {
      'name': 'cough',
      'date': '2023-11-26',
      'owner_id': 'user123',
      'strength': 10,
      'is_bool': true
    },
    {
      'name': 'headache',
      'date': '2023-11-26',
      'owner_id': 'user123',
      'strength': 10,
      'is_bool': false
    },
    {
      'name': 'cough',
      'date': '2023-11-26',
      'owner_id': 'user123',
      'strength': 10,
      'is_bool': true
    },
    {
      'name': 'headache',
      'date': '2023-11-26',
      'owner_id': 'user123',
      'strength': 10,
      'is_bool': false
    },
    {
      'name': 'cough',
      'date': '2023-11-26',
      'owner_id': 'user123',
      'strength': 10,
      'is_bool': true
    },
    {
      'name': 'headache',
      'date': '2023-11-26',
      'owner_id': 'user123',
      'strength': 10,
      'is_bool': false
    },
    {
      'name': 'cough',
      'date': '2023-11-26',
      'owner_id': 'user123',
      'strength': 10,
      'is_bool': true
    },
    // Добавьте остальные симптомы здесь
  ];

  static void updateSymptomValue(String key, int value) {
    for (var symptom in symptoms) {
      if (symptom['name'] == key) {
        symptom['value'] = value;
      }
    }
  }

  static bool getSymptomIsBoolean(String key) {
    for (var symptom in symptoms) {
      if (symptom['name'] == key) {
        return symptom['is_bool'];
      }
    }
    return false;
  }
}

class Choice {
  final String label;
  final bool isBoolean;

  Choice({
    required this.label,
    required this.isBoolean,
  });
}

class SymptomeData {
  final List<Choice> choices;

  SymptomeData({
    required this.choices,
  });
}

class StatsWidget extends StatefulWidget {
  const StatsWidget({super.key});

  @override
  State<StatsWidget> createState() => _StatsWidgetState();
}

class _StatsWidgetState extends State<StatsWidget> {
  final SymptomeData patientData = SymptomeData(
    choices: [
      Choice(label: 'Слабость, утомляемость', isBoolean: false),
      Choice(label: 'Рвота', isBoolean: true),
      Choice(label: 'Уменьшение диуреза', isBoolean: true),
      Choice(label: 'Ухудшение памяти', isBoolean: true),
      Choice(label: 'Нарушение моторных функций', isBoolean: true),
      Choice(label: 'Болевой синдром', isBoolean: false),
      Choice(label: 'Хрипы', isBoolean: true),
      Choice(label: 'Бронхоспазм', isBoolean: true),
      Choice(label: 'Боль в левой части грудной клетки', isBoolean: true),
      Choice(label: 'Аритмия', isBoolean: true),
      Choice(label: 'Депрессия, тревога', isBoolean: false),
      Choice(label: 'Спутанность сознания (химический мозг)', isBoolean: true),
      Choice(label: 'Прилив жара к верхней части туловища', isBoolean: true),
      Choice(label: 'Нейродермит (сыпь, зуд)', isBoolean: true),
      Choice(label: 'Стоматит', isBoolean: true),
      Choice(label: 'Периферическая невропатия руки', isBoolean: true),
      Choice(label: 'Периферическая невропатия ноги', isBoolean: true),
      Choice(label: 'Мигрень', isBoolean: false),
    ],
  );

  final noteInputController = TextEditingController();

  void _cancel() => Get.back();

  void generateRandomSymptoms(list) {
    Random random = Random();
    for (var symptom in list) {
      if (symptom['is_bool']) {
        symptom['strength'] = random.nextInt(2);
      } else {
        symptom['strength'] = random.nextInt(4);
      }
    }
  }

 void _sendSymptomsDataToServer(symptoms) {
  sendSymptomsDataToServer(symptoms);
}


  void _submit() {
    // Get.back();
    final List<Map<String, dynamic>> symptoms = [
    {
      'name': 'headache',
      'date': '2023-11-26',
      'owner_id': 10,
      'strength': 1,
      'is_bool': false
    },
    {
      'name': 'cough',
      'date': '2023-11-26',
      'owner_id': 10,
      'strength': 1,
      'is_bool': true
    },
    {
      'name': 'headache',
      'date': '2023-11-26',
      'owner_id': 10,
      'strength': 1,
      'is_bool': false
    },
    {
      'name': 'cough',
      'date': '2023-11-26',
      'owner_id': 10,
      'strength': 1,
      'is_bool': true
    },
    {
      'name': 'headache',
      'date': '2023-11-26',
      'owner_id': 10,
      'strength': 3,
      'is_bool': false
    },
    {
      'name': 'cough',
      'date': '2023-11-26',
      'owner_id': 10,
      'strength': 0,
      'is_bool': true
    },
    {
      'name': 'headache',
      'date': '2023-11-26',
      'owner_id': 10,
      'strength': 2,
      'is_bool': false
    },
    {
      'name': 'cough',
      'date': '2023-11-26',
      'owner_id': 10,
      'strength': 1,
      'is_bool': true
    },
    // Добавьте остальные симптомы здесь
  ];


    generateRandomSymptoms(symptoms);
    _sendSymptomsDataToServer(symptoms);

    Get.snackbar(
      'Успешно!',
      'Значения добавлены',
      backgroundColor: Colors.tealAccent.withOpacity(0.4),
      colorText: Colors.teal.shade900,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(milliseconds: 1500),
      animationDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    final noteInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('Добавьте заметку'),
    );
    var listLength = patientData.choices.length;

    return AppStyleCard(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int index = 0; index < listLength; index++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Column(children: [
                  Divider(),
                  patientData.choices[index].isBoolean
                      ? HorizontalRadio(
                          symptome: patientData.choices[index].label,
                          elIndex: index)
                      : SliderChoice(
                          label: patientData.choices[index].label,
                          elIndex: index),
                ]),
              ),
            TextField(
              controller: noteInputController,
              decoration: noteInputDecoration,
              maxLines: 3,
            ),
            SizedBox(height: 15),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 300),
              child: ElevatedButton(
                style: AppButtonStyle.filledRoundedButton,
                onPressed: _submit,
                child: const Text('Сохранить'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliderChoice extends StatefulWidget {
  final String label;
  final int elIndex;
  const SliderChoice({
    super.key,
    required this.label,
    required this.elIndex,
  });

  @override
  State<SliderChoice> createState() => _SliderChoiceState();
}

class _SliderChoiceState extends State<SliderChoice> {
  double _currentSliderValue = 0;
  List<String> labels = ['нет', 'слабо', 'умеренно', 'сильно'];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: widget.elIndex % 2 == 0 ? Colors.white : Colors.white),
      child: Column(
        children: [
          Text(
            widget.label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Slider(
            label: labels[_currentSliderValue.toInt()],
            activeColor: AppColors.activeColor,
            value: _currentSliderValue,
            max: 3,
            divisions: 3,
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

class HorizontalRadio extends StatefulWidget {
  final String symptome;
  final int elIndex;

  const HorizontalRadio({
    super.key,
    required this.symptome,
    required this.elIndex,
  });

  @override
  _HorizontalRadioState createState() => _HorizontalRadioState();
}

class _HorizontalRadioState extends State<HorizontalRadio> {
  int _selectedValue = 1;
  final List<String> _choices = ['Нет', 'Да'];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: widget.elIndex % 2 == 0 ? Colors.white : Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.symptome,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List<Widget>.generate(2, (int index) {
              return Row(
                children: [
                  Radio(
                    activeColor: AppColors.activeColor,
                    value: index,
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value!;
                      });
                    },
                  ),
                  Text(_choices[index]),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
