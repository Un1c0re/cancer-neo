import 'package:diplom/views/widgets/symptoms/edit_symptom_widget.dart';
import 'package:flutter/material.dart';

class EditSymptomScreen extends StatefulWidget {
  final Function onUpdate;
  final String oldName;
  const EditSymptomScreen({
    super.key, 
    required this.onUpdate, 
    required this.oldName,
  });

  @override
  State<EditSymptomScreen> createState() => _EditSymptomScreenState();
}

class _EditSymptomScreenState extends State<EditSymptomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Изменить симптом'),
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
        child: EditSymptomWidget(onUpdate: widget.onUpdate, oldName: widget.oldName),
      ),
    );
  }
}
