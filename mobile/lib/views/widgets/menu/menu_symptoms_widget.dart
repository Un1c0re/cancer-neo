import 'package:cancerneo/helpers/datetime_helpers.dart';
import 'package:cancerneo/views/widgets/symptoms/custom_symptom_widget.dart';
import 'package:cancerneo/views/widgets/symptoms/marker_symptom_widget.dart';
import 'package:cancerneo/views/widgets/symptoms/num_symptom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cancerneo/services/database_service.dart';
import 'package:cancerneo/models/symptom_value_model.dart';

import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/utils/app_style.dart';
import 'package:cancerneo/utils/app_widgets.dart';
import 'package:cancerneo/utils/constants.dart';

import 'package:cancerneo/views/screens/symptoms/add_symptom_screen.dart';
import 'package:cancerneo/views/widgets/symptoms/bool_symptom_widget.dart';
import 'package:cancerneo/views/widgets/symptoms/grade_symptom_widget.dart';

class SymptomsWidget extends StatefulWidget {
  final String appBarTitle;
  const SymptomsWidget({
    super.key,
    required this.appBarTitle,
  });

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
    setState(() {});
  }

  void updateSelectedDate(DateTime pickedDate) {
    selectedDate = pickedDate;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadNoteForSelectedDate();
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

    setState(() {});
  }

  void _incrementDate() {
    if (selectedDate.isBefore(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
      setState(() {
        selectedDate = selectedDate.add(const Duration(days: 1));
        updateData();
      });
    }
  }

  void _decrementDate() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: -1));
      updateData();
    });
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
          constraints: BoxConstraints(
            maxWidth: DeviceScreenConstants.screenWidth * 0.9,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.appBarTitle,
                style: const TextStyle(fontSize: 26),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.keyboard_arrow_left),
                      onPressed: _decrementDate,
                    ),
                    TextButton(
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.zero),
                        foregroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 255, 255, 255)),
                      ),
                      onPressed: () => selectDate(context, selectedDate, updateSelectedDate),
                      child: Text(
                        customFormat
                            .format(selectedDate)
                            .toString()
                            .substring(0, 10),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.keyboard_arrow_right),
                      onPressed: _incrementDate,
                    ),
                  ],
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
                    return const Center(
                        child: CircularProgressIndicator(
                      color: AppColors.activeColor,
                    ));
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final List<SymptomDetails> symptoms = snapshot.data!;

                    // Массивы для каджого типа симптомов
                    final List<SymptomDetails> gradeSymptoms = [];
                    final List<SymptomDetails> boolSymptoms = [];
                    final List<SymptomDetails> numSymptoms = [];
                    final List<SymptomDetails> markerSymptoms = [];
                    final List<SymptomDetails> customSymptoms = [];

                    // TODO: изменить порядок отображения симптомов
                    
                    // Заполнение массива - разделение данных
                    for (int i = 0; i < symptoms.length; i++) {
                      if (symptoms[i].symptomType == 'bool') {
                        boolSymptoms.add(symptoms[i]);
                      } else if (symptoms[i].symptomType == 'grade') {
                        gradeSymptoms.add(symptoms[i]);
                      } else if (symptoms[i].symptomType == 'numeric') {
                        numSymptoms.add(symptoms[i]);
                      } else if (symptoms[i].symptomType == 'marker') {
                        markerSymptoms.add(symptoms[i]);
                      } else {
                        customSymptoms.add(symptoms[i]);
                      }
                    }

                    // Массив для отображения виджетов по типу:
                    // условный + 2 двухуровневых
                    final List<Widget> combinedSymptomsWidgets = [];
                    int gradeIndex = 0;
                    int boolIndex = 0;
                    int numIndex = 0;
                    int markerIndex = 0;
                    int customIndex = 0;

                    combinedSymptomsWidgets.add(const SizedBox(height: 10));

                    while (gradeIndex < gradeSymptoms.length ||
                        boolIndex < boolSymptoms.length) {
                      // Добавляем GradeSymptom, если он доступен
                      if (gradeIndex < gradeSymptoms.length) {
                        combinedSymptomsWidgets.add(
                          GradeSymptomWidget(
                            symptomID: gradeSymptoms[gradeIndex].id,
                            label: gradeSymptoms[gradeIndex].symptomName,
                            symptomCurrentValue:
                                gradeSymptoms[gradeIndex].symptomValue.toInt(),
                          ),
                        );
                        gradeIndex++;
                      }
                      combinedSymptomsWidgets.add(const SizedBox(height: 20));
                      // Добавляем две строки с BoolSymptomWidget, если они доступны
                      List<Widget> rowWidgets = [];
                      for (int i = 0;
                          i < 4 && boolIndex < boolSymptoms.length;
                          i++, boolIndex++) {
                        rowWidgets.add(
                          BoolSymptomWidget(
                            symptomID: boolSymptoms[boolIndex].id,
                            label: boolSymptoms[boolIndex].symptomName,
                            value: boolSymptoms[boolIndex].symptomValue.toInt(),
                          ),
                        );
                        if ((i + 1) % 2 == 0 ||
                            boolIndex == boolSymptoms.length) {
                          // Каждые два BoolSymptomWidget добавляем в Row и сбрасываем rowWidgets
                          combinedSymptomsWidgets.add(Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.from(rowWidgets)));
                          rowWidgets.clear();
                        }
                        combinedSymptomsWidgets.add(const SizedBox(height: 20));
                      }
                    }

                    while (numIndex < numSymptoms.length) {
                      combinedSymptomsWidgets.add(NumSymptomWidget(
                        symptomID: numSymptoms[numIndex].id,
                        label: numSymptoms[numIndex].symptomName,
                        value: numSymptoms[numIndex].symptomValue,
                      ));
                      numIndex++;
                      combinedSymptomsWidgets.add(const SizedBox(height: 20));
                    }
                    while (markerIndex < markerSymptoms.length) {
                      combinedSymptomsWidgets.add(MarkerSymptomWidget(
                        symptomID: markerSymptoms[markerIndex].id,
                        label: markerSymptoms[markerIndex].symptomName,
                        value: markerSymptoms[markerIndex].symptomValue,
                      ));
                      markerIndex++;
                      combinedSymptomsWidgets.add(const SizedBox(height: 20));
                    }
                    while (customIndex < customSymptoms.length) {
                      combinedSymptomsWidgets.add(CustomSymptomWidget(
                        symptomID: customSymptoms[customIndex].id,
                        label: customSymptoms[customIndex].symptomName,
                        value: customSymptoms[customIndex].symptomValue,
                        onUpdate: updateData,
                      ));
                      customIndex++;
                      combinedSymptomsWidgets.add(const SizedBox(height: 20));
                    }
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: DeviceScreenConstants.screenWidth * 0.9),
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
                        onEditingComplete: () => _handleNoteSubmission(),
                        onTapOutside: (_) { FocusScope.of(context).unfocus(); _handleNoteSubmission(); },
                        // onSubmitted: (_) => _handleNoteSubmission(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
