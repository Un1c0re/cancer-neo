import 'package:diplom/views/widgets/symptoms/custom_symptom_widget.dart';
import 'package:diplom/views/widgets/symptoms/num_symptom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:diplom/services/database_service.dart';
import 'package:diplom/models/symptom_value_model.dart';

import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_style.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/utils/constants.dart';

import 'package:diplom/views/screens/symptoms/add_symptom_screen.dart';
import 'package:diplom/views/widgets/symptoms/bool_symptom_widget.dart';
import 'package:diplom/views/widgets/symptoms/grade_symptom_widget.dart';

class SymptomsWidget extends StatefulWidget {
  const SymptomsWidget({super.key});

  @override
  State<SymptomsWidget> createState() => _SymptomsWidgetState();
}

class _SymptomsWidgetState extends State<SymptomsWidget> {
  final DatabaseService _databaseService = Get.find();
  final _notesInputController = TextEditingController();
  final notesInputDecoration = AppStyleTextFields.sharedDecoration;
  DateTime selectedDate = DateTime.now();

  void _loadNoteForSelectedDate() async {
    final note = await _databaseService.database.dayNotesDao.getDayNote(
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day));
    if (note != null) {
      _notesInputController.text = note.note;
    }
  }

  void updateData() {
    _notesInputController.clear();
    _loadNoteForSelectedDate();
    setState(() {
      // Это заставит виджет перерисоваться
    });
  }

  @override
  void initState() {
    super.initState();
    _loadNoteForSelectedDate();
  }

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
      selectedDate = picked;
      updateData();
      // setState(() {});
    }
  }

  void _addSymptom() => Get.to(() => AddSymptomScreen(
        onUpdate: updateData,
      ));

  void _handleNoteSubmission() async {
    final date =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    final noteText = _notesInputController.text.trim();

    final ifExists =
        await _databaseService.database.dayNotesDao.ifDayNoteExists(date);

    if (ifExists) {
      await _databaseService.database.dayNotesDao.updateDayNote(
        date: date,
        note: noteText,
      );
    } else {
      await _databaseService.database.dayNotesDao.addDayNote(
        date: date,
        note: noteText,
      );
    }

    // Обновите состояние, чтобы отразить изменения
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Future<List<SymptomDetails>> getSymptomData() async {
      DateTime date =
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
      List<SymptomDetails> symptomDetails = await _databaseService
          .database.symptomsValuesDao
          .getSymptomsDetails(date);

      if (symptomDetails.isEmpty) {
        await _databaseService.database.symptomsValuesDao
            .initSymptomsValues(date);
        symptomDetails = await _databaseService.database.symptomsValuesDao
            .getSymptomsDetails(date);
      }

      return symptomDetails;
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
                        final List<SymptomDetails> numSymptoms = [];
                        final List<SymptomDetails> customSymptoms = [];

                        for (int i = 0; i < symptoms.length; i++) {
                          if (symptoms[i].symptomType == 'bool') {
                            boolSymptoms.add(symptoms[i]);
                          } else if (symptoms[i].symptomType == 'grade') {
                            gradeSymptoms.add(symptoms[i]);
                          } else if (symptoms[i].symptomType == 'numeric') {
                            numSymptoms.add(symptoms[i]);
                          } else {
                            customSymptoms.add(symptoms[i]);
                          }
                        }

                        final List<Widget> combinedSymptomsWidgets = [];
                        int gradeIndex = 0;
                        int boolIndex = 0;
                        int numIndex = 0;
                        int customIndex = 0;

                        combinedSymptomsWidgets.add(SizedBox(height: 10));

                        while (gradeIndex < gradeSymptoms.length ||
                            boolIndex < boolSymptoms.length) {
                          // Добавляем GradeSymptom, если он доступен
                          if (gradeIndex < gradeSymptoms.length) {
                            combinedSymptomsWidgets.add(
                              GradeSymptomWidget(
                                symptomID: gradeSymptoms[gradeIndex].id,
                                label: gradeSymptoms[gradeIndex].symptomName,
                                symptomCurrentValue:
                                    gradeSymptoms[gradeIndex].symptomValue,
                              ),
                            );
                            gradeIndex++;
                          }
                          combinedSymptomsWidgets.add(SizedBox(height: 20));
                          // Добавляем две строки с BoolSymptomWidget, если они доступны
                          List<Widget> rowWidgets = [];
                          for (int i = 0;
                              i < 4 && boolIndex < boolSymptoms.length;
                              i++, boolIndex++) {
                            rowWidgets.add(
                              BoolSymptomWidget(
                                symptomID: boolSymptoms[boolIndex].id,
                                label: boolSymptoms[boolIndex].symptomName,
                                value: boolSymptoms[boolIndex].symptomValue,
                              ),
                            );
                            if ((i + 1) % 2 == 0 ||
                                boolIndex == boolSymptoms.length) {
                              // Каждые два BoolSymptomWidget добавляем в Row и сбрасываем rowWidgets
                              combinedSymptomsWidgets.add(Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.from(rowWidgets)));
                              rowWidgets.clear();
                            }
                            combinedSymptomsWidgets.add(SizedBox(height: 20));
                          }
                        }
                        while (numIndex < numSymptoms.length) {
                          combinedSymptomsWidgets.add(NumSymptomWidget(
                            symptomID: numSymptoms[numIndex].id,
                            label: numSymptoms[numIndex].symptomName,
                            value: numSymptoms[numIndex].symptomValue,
                          ));
                          numIndex++;
                          combinedSymptomsWidgets.add(SizedBox(height: 20));
                        }
                        while (customIndex < customSymptoms.length) {
                          combinedSymptomsWidgets.add(CustomSymptomWidget(
                            symptomID: customSymptoms[customIndex].id,
                            label: customSymptoms[customIndex].symptomName,
                            value: customSymptoms[customIndex].symptomValue,
                            onUpdate: updateData,
                          ));
                          customIndex++;
                          combinedSymptomsWidgets.add(SizedBox(height: 20));
                        }
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth:
                                  DeviceScreenConstants.screenWidth * 0.9),
                          child: Column(children: combinedSymptomsWidgets),
                        );
                      }
                    }),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: DeviceScreenConstants.screenWidth * 0.9,
                        maxHeight: DeviceScreenConstants.screenHeight * 0.1),
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
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _handleNoteSubmission(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            )));
  }
}
