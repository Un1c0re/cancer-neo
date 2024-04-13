import 'package:flutter/material.dart';
import '../../widgets/docs/add_doc_widget.dart';

class AddDocScreen extends StatefulWidget {
  final Function onUpdate;
  const AddDocScreen({
    super.key,
    required this.onUpdate,
  });

  @override
  State<AddDocScreen> createState() => _AddDocScreenState();
}

class _AddDocScreenState extends State<AddDocScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Добавить документ',
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
        child: AddDocWidget(onUpdate: widget.onUpdate),
      ),
    );
  }
}
