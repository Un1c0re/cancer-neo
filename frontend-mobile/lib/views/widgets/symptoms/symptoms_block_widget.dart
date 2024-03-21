// import 'package:diplom/utils/app_widgets.dart';
// import 'package:diplom/utils/constants.dart';
// import 'package:diplom/views/widgets/symptoms/grade_symptom_widget.dart';
// import 'package:flutter/material.dart';

// class SymptomsBlock extends StatelessWidget {
//   final String gradeSymptom;
//   final String boolSymptom1;
//   final String boolSymptom2;
//   final String boolSymptom3;
//   final String boolSymptom4;

//   const SymptomsBlock({
//     super.key,
//     required this.gradeSymptom,
//     required this.boolSymptom1,
//     required this.boolSymptom2,
//     required this.boolSymptom3,
//     required this.boolSymptom4,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ConstrainedBox(
//       constraints: BoxConstraints(
//         maxWidth: DeviceScreenConstants.screenWidth * 0.9,
//       ),
//       child: Column(
//         children: [
//           GradeSymptom(
//             label: gradeSymptom,
//             elIndex: 0,
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ApppStyleChip(label: boolSymptom1),
//               ApppStyleChip(label: boolSymptom2),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ApppStyleChip(label: boolSymptom3),
//               ApppStyleChip(label: boolSymptom4),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
