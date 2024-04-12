import 'dart:io';
import 'dart:typed_data';

import 'package:diplom/helpers/datetime_helpers.dart';
import 'package:diplom/helpers/get_helpers.dart';
import 'package:diplom/helpers/validate_helpers.dart';
import 'package:diplom/models/doc_type_model.dart';
import 'package:diplom/models/docs_models.dart';
import 'package:diplom/services/database_service.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_style.dart';
import '../../../utils/constants.dart';

class EditDocWidget extends StatefulWidget {
  final int docID;
  final Function onUpdate;
  const EditDocWidget({
    super.key,
    required this.onUpdate,
    required this.docID,
  });

  @override
  State<EditDocWidget> createState() => _EditDocWidgetState();
}

class _EditDocWidgetState extends State<EditDocWidget> {
  final _nameInputController = TextEditingController();
  final _placeInputController = TextEditingController();
  final _dateInputController = TextEditingController();
  final _notesInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isateInitialized = false;
  bool _isFileLoaded = false;

  File? docFile;
  Uint8List? docFileBytes;
  late DateTime _pickedDate;
  int? selectedCategoryIndex;

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      docFile = File(result.files.single.path!);
      docFileBytes = await docFile!.readAsBytes();
      _isFileLoaded = true;

      setState(() {});
    }
  }

  void _onCategorySelected(int? index) {
    setState(() {
      selectedCategoryIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    final DatabaseService service = Get.find();

    final nameInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('название документа'),
    );

    final dateInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('дд.мм.гггг'),
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

    final placeInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('место получения'),
    );

    final notesInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('примечания'),
    );

    Future<void> updateDoc(String docName, int docType, DateTime docDate,
        String docPlace, String docNotes, Uint8List? docFile) async {
      await service.database.docsDao.updateDoc(
        docId: widget.docID,
        docName: docName,
        docType: docType,
        docDate: docDate,
        docPlace: docPlace,
        docNotes: docNotes,
        pdfFile: docFile,
      );
    }

    Future<DocModel?> getDocument(id) async {
      return await service.database.docsDao.getDoc(id);
    }

    Future<List<DoctypeModel>> getDocTypes() async {
      return await service.database.doctypesDao.getAllDocTypes();
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: DeviceScreenConstants.screenHeight * 0.75,
            child: AppStyleCard(
              backgroundColor: Colors.white,
              child: FutureBuilder<DocModel?>(
                  future: getDocument(widget.docID),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final data = snapshot.data!;
                      _nameInputController.text = data.docName;
                      _placeInputController.text = data.docPlace;
                      if(!_isateInitialized) {
                        _pickedDate = data.docDate;
                        _isateInitialized = true;
                      }
                      _dateInputController.text = customFormat.format(_pickedDate).toString().substring(0, 10);
                      _notesInputController.text = data.docNotes;
                      if (data.pdfFile != null && !_isFileLoaded) {
                        docFileBytes = data.pdfFile;
                        _isFileLoaded = true;
                      }

                      return Form(
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
                                  style:
                                      AppButtonStyle.textRoundedButton.copyWith(
                                    backgroundColor: MaterialStatePropertyAll(
                                        docFileBytes == null
                                            ? Colors.transparent
                                            : Colors.tealAccent
                                                .withOpacity(0.4)),
                                  ),
                                  child: Text(
                                    docFileBytes == null
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            FutureBuilder<List<DoctypeModel>>(
                              future: getDocTypes(),
                              builder: ((context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  final docTypesList = snapshot.data!;

                                  return DocumentTypeSelector(
                                    onSelected: _onCategorySelected,
                                    docTypes: docTypesList,
                                    currentSelectedIndex: selectedCategoryIndex,
                                  );
                                }
                              }),
                            ),
                            TextFormField(
                                decoration: dateInputDecoration,
                                cursorColor: AppColors.activeColor,
                                controller: _dateInputController,
                                validator: validateDate,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction),
                            TextFormField(
                              decoration: placeInputDecoration,
                              cursorColor: AppColors.activeColor,
                              controller: _placeInputController,
                              validator: validateString,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            TextField(
                              maxLines: 3,
                              decoration: notesInputDecoration,
                              cursorColor: AppColors.activeColor,
                              controller: _notesInputController,
                            ),
                          ],
                        ),
                      );
                    }
                  })),
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
                        int docType = selectedCategoryIndex ?? 1;
                        DateTime docDate =
                            customFormat.parse(_dateInputController.text);
                        String docPlace = _placeInputController.text;
                        String docNote = _notesInputController.text;

                        await updateDoc(docName, docType, docDate, docPlace,
                            docNote, docFileBytes);
                        editAction('Документ изменен');
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
    );
  }
}

class DocumentTypeSelector extends StatefulWidget {
  final int? currentSelectedIndex;
  final List<DoctypeModel> docTypes;
  final Function(int?) onSelected;

  const DocumentTypeSelector({
    super.key,
    this.currentSelectedIndex,
    required this.onSelected,
    required this.docTypes,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DocumentTypeSelectorState createState() => _DocumentTypeSelectorState();
}

class _DocumentTypeSelectorState extends State<DocumentTypeSelector> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.currentSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonFormField<DoctypeModel>(
        decoration: InputDecoration(
          labelText: 'Категория документа',
          labelStyle: const TextStyle(color: AppColors.activeColor),
          filled: true,
          fillColor: AppColors.fillColor,
          focusColor: AppColors.activeColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
        value: selectedIndex != null
            ? widget.docTypes.firstWhere(
                (doctype) => doctype.id == selectedIndex,
                orElse: () => widget.docTypes[0])
            : widget.docTypes[0],
        onChanged: (DoctypeModel? newValue) {
          setState(() {
            selectedIndex = newValue?.id;
          });
          widget.onSelected(newValue?.id);
        },
        items: widget.docTypes.map((DoctypeModel docType) {
          return DropdownMenuItem<DoctypeModel>(
            value: docType,
            child: Text(docType.name),
          );
        }).toList(),
      ),
    );
  }
}
