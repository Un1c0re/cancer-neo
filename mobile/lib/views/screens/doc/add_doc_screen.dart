import 'dart:io';
import 'dart:typed_data';

import 'package:diplom/helpers/datetime_helpers.dart';
import 'package:diplom/helpers/get_helpers.dart';
import 'package:diplom/helpers/validate_helpers.dart';
import 'package:diplom/models/doc_type_model.dart';
import 'package:diplom/services/database_service.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_style.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/utils/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  late DateTime _pickedDate; // date pick

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      docFile = File(result.files.single.path!);
      docFileBytes = await docFile!.readAsBytes();

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _pickedDate = DateTime.now();
    _dateInputController.text =
        customFormat.format(_pickedDate).toString().substring(0, 10);
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
        onPressed: () async {
          DateTime? newDate = await selectDate(context, _pickedDate);
          if (newDate != null) {
            setState(() {
              _pickedDate = newDate;
              _dateInputController.text =
                  customFormat.format(_pickedDate).toString().substring(0, 10);
            });
          }
        },
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
        String docPlace, String docNotes, Uint8List? docFile) async {
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
                height: DeviceScreenConstants.screenHeight * 0.75,
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
                        TextFormField(
                          decoration: nameInputDecoration,
                          cursorColor: AppColors.activeColor,
                          controller: _nameInputController,
                          validator: validateString,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        TextFormField(
                          decoration: typeInputDecoration,
                          controller: _typeInputController,
                        ),
                        TextFormField(
                          decoration: dateInputDecoration,
                          cursorColor: AppColors.activeColor,
                          controller: _dateInputController,
                          validator: validateDate,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        TextFormField(
                          decoration: placeInputDecoration,
                          cursorColor: AppColors.activeColor,
                          controller: _placeInputController,
                          validator: validateString,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
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
                                docNote, docFileBytes);
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
