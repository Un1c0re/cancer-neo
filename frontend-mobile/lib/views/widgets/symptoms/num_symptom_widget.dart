import 'package:diplom/utils/app_style.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/utils/constants.dart';
import 'package:flutter/material.dart';

class NumSymptoms extends StatefulWidget {
  final String label;
  const NumSymptoms({
    super.key, 
    required this.label
  });

  @override
  State<NumSymptoms> createState() => _NumSymptomsState();
}

class _NumSymptomsState extends State<NumSymptoms> {
  final valueInputController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final valueInputDecoration = AppStyleTextFields.sharedDecoration;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: DeviceScreenConstants.screenHeight * 0.08,
        maxWidth: DeviceScreenConstants.screenWidth * 0.9,
      ),
      child: AppStyleCard(
        backgroundColor: Colors.white, 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label, 
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 60,
              ),
              child: TextField(
                decoration: valueInputDecoration,
                controller: valueInputController,
              ),
            ),
          ],
        )
      ),
    );
  }
}