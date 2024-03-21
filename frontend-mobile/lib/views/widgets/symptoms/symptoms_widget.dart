import 'package:diplom/models/symptoms_models.dart';
import 'package:diplom/services/database_service.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_style.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/utils/constants.dart';
import 'package:diplom/views/screens/symptoms/add_symptom_screen.dart';
import 'package:diplom/views/widgets/symptoms/bool_symptom_widget.dart';
import 'package:diplom/views/widgets/symptoms/grade_symptom_widget.dart';
import 'package:diplom/views/widgets/symptoms/num_symptom_widget.dart';
import 'package:diplom/views/widgets/symptoms/symptoms_block_widget.dart';
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
    final DatabaseService _databaseService = Get.find();

    Future<List<SymptomDetails>> getSymptomData() async {
      return await _databaseService.database.symptomsDao
          .getSymptomsDetails(selectedDate);
    }

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
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: getSymptomData(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final List<SymptomDetails> symptoms = snapshot.data!;
                    final List<SymptomDetails> gradeSymptoms = [];
                    final List<SymptomDetails> boolSymptoms = [];

                    for (int i = 0; i < symptoms.length; i++) {
                      if (symptoms[i].symptomType == 'grade') {
                        gradeSymptoms.add(symptoms[i]);
                      } else if (symptoms[i].symptomType == 'bool') {
                        boolSymptoms.add(symptoms[i]);
                      } 
                    }

                    final List<Widget> gradeSymptomsWidgets = [];
                    for(int i = 0; i < gradeSymptoms.length; i ++) {
                      gradeSymptomsWidgets.add(
                        GradeSymptom(
                          label: gradeSymptoms[i].symptomName, 
                          elIndex: gradeSymptoms[i].symptomValue
                        ),
                      );
                    }

                    final List<Widget> boolSymptomsWidgets = [];
                    for(int i = 0; i < boolSymptoms.length; i ++) {
                      gradeSymptomsWidgets.add(
                        BoolSymptomWidget(
                          label: boolSymptoms[i].symptomName,
                          value: boolSymptoms[i].symptomValue,
                        ),
                      );
                    }

                    return Column(
                      children: [
                        ...gradeSymptomsWidgets,
                        ...boolSymptomsWidgets,
                      ],
                    );
                  }
                }),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth:
                      DeviceScreenConstants.screenWidth * 0.9,
                  maxHeight:
                      DeviceScreenConstants.screenHeight * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: AppButtonStyle.filledRoundedButton,
                        onPressed: _addSymptom,
                        child: const Text('Добавить симптом'),
                      ),
                    ),
                  ],
                ),
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
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}