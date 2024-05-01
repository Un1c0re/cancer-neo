import 'package:cancerneo/views/widgets/symptoms/add_symptom_widget.dart';
import 'package:flutter/material.dart';

class AddSymptomScreen extends StatefulWidget {
  final Function onUpdate;
  const AddSymptomScreen({super.key, required this.onUpdate});

  @override
  State<AddSymptomScreen> createState() => _AddSymptomScreenState();
}

class _AddSymptomScreenState extends State<AddSymptomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Добавить симптом',
          style: TextStyle(
            fontSize: 26,
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
        padding: const EdgeInsets.all(10),
        child: AddSymptomWidget(onUpdate: widget.onUpdate),
      ),
    );
  }
}
