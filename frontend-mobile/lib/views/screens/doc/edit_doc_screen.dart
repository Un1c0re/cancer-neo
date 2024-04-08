import 'package:diplom/views/widgets/docs/edit_doc_widget.dart';
import 'package:flutter/material.dart';

class EditDocScreen extends StatefulWidget {
  final int docID;
  final Function onUpdate;
  
  const EditDocScreen({
    super.key, 
    required this.docID,
    required this.onUpdate,
  });

  @override
  State<EditDocScreen> createState() => _EditDocScreenState();
}

class _EditDocScreenState extends State<EditDocScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Изменить документ'),
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
        child: EditDocWidget(docID: widget.docID, onUpdate: widget.onUpdate),
      ),
    );
  }
}
