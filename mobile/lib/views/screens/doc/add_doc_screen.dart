import 'dart:io';
import 'dart:typed_data';

import 'package:cancerneo/helpers/datetime_helpers.dart';
import 'package:cancerneo/helpers/get_helpers.dart';
import 'package:cancerneo/helpers/validate_helpers.dart';
import 'package:cancerneo/models/doc_type_model.dart';
import 'package:cancerneo/services/database_service.dart';
import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/utils/app_style.dart';
import 'package:cancerneo/utils/app_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class AddDocScreen extends StatefulWidget {
  final DoctypeModel doctype;
  final Function onUpdate;

  const AddDocScreen({
    super.key,
    required this.doctype,
    required this.onUpdate,
  });

  @override
  State<AddDocScreen> createState() => _AddDocScreenState();
}

class _AddDocScreenState extends State<AddDocScreen> {
  // TextField Controllers
  final _nameInputController = TextEditingController();
  final _dateInputController = TextEditingController();
  final _typeInputController = TextEditingController();
  final _placeInputController = TextEditingController();
  final _notesInputController = TextEditingController();

  // Form Key to check if validate was success
  final _formKey = GlobalKey<FormState>();

  File? docFile; // file by itself
  Uint8List? docFileBytes; // bytes to store in db
  String? filePath;
  late DateTime _pickedDate; // date pick

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      docFile = File(result.files.single.path!);
      docFileBytes = await docFile!.readAsBytes();
      filePath = await saveFile(docFileBytes!, result.files.single.extension);

      setState(() {});
    }
  }

  Future<String> saveFile(Uint8List fileBytes, String? extension) async {
    final directory = await getApplicationDocumentsDirectory();
    String filePath;

    if (extension != null && extension.toLowerCase() == 'pdf') {
      filePath =
          '${directory.path}/document_${DateTime.now().millisecondsSinceEpoch}.pdf';
    } else if (extension != null &&
        (extension.toLowerCase() == 'png' ||
            extension.toLowerCase() == 'jpg' ||
            extension.toLowerCase() == 'jpeg')) {
      filePath =
          '${directory.path}/image_${DateTime.now().millisecondsSinceEpoch}.$extension';
    } else {
      throw Exception('Unsupported file type');
    }

    final file = File(filePath);
    await file.writeAsBytes(fileBytes);
    return filePath;
  }

  @override
  void initState() {
    super.initState();
    _pickedDate = DateTime.now();
    _dateInputController.text =
        customFormat.format(_pickedDate).toString().substring(0, 10);
  }

  void updateSelectedDate(DateTime pickedDate) {
    _pickedDate = pickedDate;
    _dateInputController.text =
        customFormat.format(_pickedDate).toString().substring(0, 10);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseService service = Get.find();
    _typeInputController.text = widget.doctype.name;

    final nameInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('название документа'),
    );

    final dateInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('Дата оформления'),
      suffix: IconButton(
        onPressed: () async => await selectDate(context, _pickedDate, updateSelectedDate),
        icon: const Icon(Icons.calendar_today),
      ),
    );

    final typeInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('тип документа'),
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      enabled: false,
    );

    final placeInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('место получения'),
    );

    final notesInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('примечания'),
    );

    Future<void> saveDoc(String docName, int docType, DateTime docDate,
        String docPlace, String docNotes, String? docFile) async {
      await service.database.docsDao.insertDoc(
        name: docName,
        type_id: docType,
        date: docDate,
        place: docPlace,
        notes: docNotes,
        file: docFile,
      );
    }

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 700,
                child: AppStyleCard(
                  backgroundColor: Colors.white,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 300,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey,
                            ),
                            borderRadius: AppBorderRounds.cardRoundedBorder,
                          ),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: selectFile,
                              style: AppButtonStyle.textRoundedButton.copyWith(
                                backgroundColor: MaterialStatePropertyAll(
                                    docFile == null
                                        ? Colors.transparent
                                        : Colors.tealAccent.withOpacity(0.4)),
                              ),
                              child: Text(
                                docFile == null
                                    ? 'Выберите файл'
                                    : 'Документ заргужен',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          decoration: nameInputDecoration,
                          cursorColor: AppColors.activeColor,
                          controller: _nameInputController,
                          validator: validateString,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          decoration: typeInputDecoration,
                          controller: _typeInputController,
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          decoration: dateInputDecoration,
                          cursorColor: AppColors.activeColor,
                          controller: _dateInputController,
                          validator: validateDate,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          decoration: placeInputDecoration,
                          cursorColor: AppColors.activeColor,
                          controller: _placeInputController,
                          validator: validateString,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          maxLines: 3,
                          decoration: notesInputDecoration,
                          cursorColor: AppColors.activeColor,
                          controller: _notesInputController,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 150,
                      child: OutlinedButton(
                        style: AppButtonStyle.outlinedRedRoundedButton,
                        onPressed: cancelAction,
                        child: const Text('Отменить'),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: AppButtonStyle.filledRoundedButton,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String docName = _nameInputController.text;
                            int docType = widget.doctype.id;
                            DateTime docDate =
                                customFormat.parse(_dateInputController.text);
                            String docPlace = _placeInputController.text;
                            String docNote = _notesInputController.text;

                            await saveDoc(docName, docType, docDate, docPlace,
                                docNote, filePath);
                            submitAction('Документ добавлен');
                            widget.onUpdate();
                          }
                        },
                        child: const Text('Подтвердить'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
