import 'dart:io';
import 'dart:typed_data';

import 'package:diplom/helpers/get_helpers.dart';
import 'package:diplom/models/docs_models.dart';
import 'package:diplom/services/database_service.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/views/screens/home/home_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_style.dart';
import '../../../utils/constants.dart';

class EditDocWidget extends StatefulWidget {
  final docID;
  final Function onUpdate;
  const EditDocWidget({
    super.key,
    required this.onUpdate,
    this.docID,
  });

  @override
  State<EditDocWidget> createState() => _EditDocWidgetState();
}

class _EditDocWidgetState extends State<EditDocWidget> {
  final _nameInputController = TextEditingController();
  final _placeInputController = TextEditingController();
  final _dateInputController = TextEditingController();
  final _notesInputController = TextEditingController();

  File? docFile;
  Uint8List? docFileBytes;
  DateTime? _pickedDateTime;
  int? selectedCategoryIndex;

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      docFile = File(result.files.single.path!);
      docFileBytes = await docFile!.readAsBytes();

      setState(() {});
    }
  }

  void _onCategorySelected(int? index) {
    setState(() {
      selectedCategoryIndex = index;
    });
  }

  @override
  void initState() {
    _pickedDateTime = DateTime.now();
    _dateInputController.text = DateTime.now().toString().substring(0, 10);
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      locale: const Locale('ru', 'RU'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      cancelText: 'Отменить',
      confirmText: 'Подтвердить',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.primaryColor,
            colorScheme:
                const ColorScheme.light(primary: AppColors.primaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _pickedDateTime) {
      setState(() {
        _pickedDateTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseService databaseService = Get.find();

    final nameInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('название документа'),
    );

    final dateInputDecoration = AppStyleTextFields.sharedDecoration.copyWith(
      label: const Text('дд.мм.гггг'),
      suffix: IconButton(
        onPressed: () => _selectDate(context),
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
      await databaseService.database.docsDao.updateDoc(
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
      return await databaseService.database.docsDao.getDoc(id);
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
                      _dateInputController.text = data.docDate.toIso8601String().substring(0, 10);
                      _notesInputController.text = data.docNotes;
                      docFileBytes = data.pdfFile;

                      return Column(
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
                                      docFile == null
                                          ? Colors.transparent
                                          : Colors.tealAccent.withOpacity(0.4)),
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
                          TextField(
                            decoration: nameInputDecoration,
                            cursorColor: AppColors.activeColor,
                            controller: _nameInputController,
                          ),
                          DocumentTypeSelector(onSelected: _onCategorySelected),
                          TextField(
                            decoration: dateInputDecoration,
                            cursorColor: AppColors.activeColor,
                            controller: _dateInputController,
                          ),
                          TextField(
                            decoration: placeInputDecoration,
                            cursorColor: AppColors.activeColor,
                            controller: _placeInputController,
                          ),
                          TextField(
                            maxLines: 3,
                            decoration: notesInputDecoration,
                            cursorColor: AppColors.activeColor,
                            controller: _notesInputController,
                          ),
                        ],
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
                      String docName = _nameInputController.text;
                      int docType = selectedCategoryIndex?? 0;
                      DateTime docDate =
                          DateTime.parse(_dateInputController.text);
                      String docPlace = _placeInputController.text;
                      String docNote = _notesInputController.text;

                      await updateDoc(docName, docType, docDate, docPlace,
                          docNote, docFileBytes);
                      editAction('Документ изменен');
                      widget.onUpdate();
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
  final Function(int?) onSelected;

  const DocumentTypeSelector({super.key, required this.onSelected});

  @override
  // ignore: library_private_types_in_public_api
  _DocumentTypeSelectorState createState() => _DocumentTypeSelectorState();
}

class _DocumentTypeSelectorState extends State<DocumentTypeSelector> {
  int? selectedIndex;
  final List<Map<String, dynamic>> categories = [
    {'name': 'Анализы', 'index': 0},
    {'name': 'КТ', 'index': 1},
    {'name': 'МРТ', 'index': 2},
    {'name': 'Исследования', 'index': 3},
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonFormField<Map<String, dynamic>>(
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
        value: categories.firstWhere(
            (category) => category['index'] == selectedIndex,
            orElse: () => categories[0]),
        onChanged: (Map<String, dynamic>? newValue) {
          setState(() {
            selectedIndex = newValue?['index'];
          });
          widget.onSelected(
              newValue?['index']); // Вызов callback-функции с индексом
        },
        items: categories.map((Map<String, dynamic> category) {
          return DropdownMenuItem<Map<String, dynamic>>(
            value: category,
            child: Text(category['name']),
          );
        }).toList(),
      ),
    );
  }
}
