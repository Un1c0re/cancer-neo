import 'package:flutter/material.dart';

import '../../widgets/docs/doc_widget.dart';

class DocScreen extends StatefulWidget {
  final int docID;
  final Function onUpdate;
  const DocScreen({
    super.key,
    required this.docID,
    required this.onUpdate,
  });

  @override
  State<DocScreen> createState() => _DocScreenState();
}

class _DocScreenState extends State<DocScreen> {

  void _updateData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Просмотр документа'),
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
        child: DocWidget(docID: widget.docID, onUpdate: _updateData),
      ),
    );
  }
}
