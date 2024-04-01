import 'dart:io';

import 'package:diplom/services/database_service.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_style.dart';
import '../../../utils/constants.dart';
import 'package:path_provider/path_provider.dart';

class AddDocWidget extends StatefulWidget {
  const AddDocWidget({super.key});

  @override
  State<AddDocWidget> createState() => _AddDocWidgetState();
}

class _AddDocWidgetState extends State<AddDocWidget> {
  final _nameInputController = TextEditingController();
  final _placeInputController = TextEditingController();
  final _dateInputController = TextEditingController();
  final _notesInputController = TextEditingController();
  
  DateTime? _pickedDateTime;
  int? selectedCategoryIndex;

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
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      cancelText: 'Отменить',
      confirmText: 'Подтвердить',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.primaryColor, // Цвет выбранной даты
            colorScheme: const ColorScheme.light(
                primary: AppColors.primaryColor), // Цветовая схема
            buttonTheme: const ButtonThemeData(
                textTheme: ButtonTextTheme.primary), // Тема кнопок
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

  void _cancel() => Get.back();

  @override
  Widget build(BuildContext context) {
    final DatabaseService _databaseService = Get.find();

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

    Future<void> saveDoc(String docName, int docType, DateTime docDate,
        String docPlace, String docNotes) async {
      await _databaseService.database.docsDao.insertDoc(
        userName: 'test testovich',
        docName: docName,
        docType: docType,
        docDate: docDate,
        docPlace: docPlace,
        docNotes: docNotes,
      );
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const _AddPhotoWidget(),
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
                      onPressed: _cancel,
                      child: const Text('Отменить'),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: AppButtonStyle.filledRoundedButton,
                      onPressed: () {
                        String docName = _nameInputController.text;
                        int docType = selectedCategoryIndex!;
                        DateTime docDate =
                            DateTime.parse(_dateInputController.text);
                        String docPlace = _placeInputController.text;
                        String docNote = _notesInputController.text;
                        saveDoc(docName, docType, docDate, docPlace, docNote);

                        Get.back();
                        Get.snackbar(
                          'Успешно!',
                          'Документ добавлен',
                          backgroundColor: Colors.tealAccent.withOpacity(0.4),
                          colorText: Colors.teal.shade900,
                          snackPosition: SnackPosition.TOP,
                          duration: const Duration(milliseconds: 1500),
                          animationDuration: const Duration(milliseconds: 500),
                        );
                      },
                      child: const Text('Подтвердить'),
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}

class _AddPhotoWidget extends StatefulWidget {
  const _AddPhotoWidget({
    super.key,
  });

  @override
  State<_AddPhotoWidget> createState() => _AddPhotoWidgetState();
}

class _AddPhotoWidgetState extends State<_AddPhotoWidget> {
  File? file;

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }

  Future<void> saveFileToLocalStorage() async {
    if (file != null) {
      var dir = await getApplicationDocumentsDirectory();
      file = File('${dir.path}/${file!.path.split('/').last}');
      await file!.writeAsBytes(await file!.readAsBytes());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: Colors.grey,
        ),
        borderRadius: AppBorderRounds.cardRoundedBorder,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          file != null
              ? Text(file!.path)
              : ElevatedButton(
                  onPressed: selectFile,
                  child: Text(
                    'Выберите файл',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: AppButtonStyle.textRoundedButton,
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
        value: categories.firstWhere((category) => category['index'] == selectedIndex, orElse: () => categories[0]),
        onChanged: (Map<String, dynamic>? newValue) {
        setState(() {
          selectedIndex = newValue?['index'];
        });
        widget.onSelected(newValue?['index']); // Вызов callback-функции с индексом
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
