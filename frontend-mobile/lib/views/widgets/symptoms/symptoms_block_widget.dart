// import 'package:diplom/utils/app_widgets.dart';
// import 'package:diplom/utils/constants.dart';
// import 'package:diplom/views/widgets/symptoms/grade_symptom_widget.dart';
// import 'package:flutter/material.dart';

// class SymptomsBlock extends StatelessWidget {
//   final List<Widget> combinedSymptomsWidgets = [];

// int gradeIndex = 0;
// int boolIndex = 0;

// while (gradeIndex < gradeSymptoms.length || boolIndex < boolSymptoms.length) {
//   // Добавляем GradeSymptom, если он доступен
//   if (gradeIndex < gradeSymptoms.length) {
//     combinedSymptomsWidgets.add(
//       GradeSymptom(
//         label: gradeSymptoms[gradeIndex].symptomName,
//         elIndex: gradeSymptoms[gradeIndex].symptomValue,
//       ),
//     );
//     gradeIndex++;
//   }

//   // Добавляем две строки с BoolSymptomWidget, если они доступны
//   List<Widget> rowWidgets = [];
//   for (int i = 0; i < 4 && boolIndex < boolSymptoms.length; i++, boolIndex++) {
//     rowWidgets.add(
//       BoolSymptomWidget(
//         label: boolSymptoms[boolIndex].symptomName,
//         value: boolSymptoms[boolIndex].symptomValue == 1,
//       ),
//     );
//     if ((i + 1) % 2 == 0 || boolIndex == boolSymptoms.length) {
//       // Каждые два BoolSymptomWidget добавляем в Row и сбрасываем rowWidgets
//       combinedSymptomsWidgets.add(Row(children: List.from(rowWidgets)));
//       rowWidgets.clear();
//     }
//   }
// }

// }
