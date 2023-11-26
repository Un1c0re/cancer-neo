import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Theme/app_style.dart';
import '../../Theme/constants.dart';
import 'package:path_provider/path_provider.dart';

class AddDocWidget extends StatefulWidget {
  const AddDocWidget({super.key});

  @override
  State<AddDocWidget> createState() => _AddDocWidgetState();
}

class _AddDocWidgetState extends State<AddDocWidget> {

  void _cancel() => Get.back();
  
  void _submit() {

    Get.back();
    
    Get.snackbar('Успешно!', 'Документ добавлен',
      backgroundColor: Colors.tealAccent.withOpacity(0.4),
      colorText: Colors.teal.shade900,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(milliseconds: 1500),
      animationDuration: const Duration(milliseconds: 500),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
    
        children: [
          SizedBox(
            height: DeviceScreenConstants.screenHeight * 0.75,
            child: _DocDataWidget(),
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
                    onPressed: _submit,
                    child: const Text('Подтвердить'),
                  ),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}


class _DocDataWidget extends StatefulWidget {
  _DocDataWidget({super.key});

  @override
  State<_DocDataWidget> createState() => _DocDataWidgetState();
}

class _DocDataWidgetState extends State<_DocDataWidget> {
  final _nameInputController  = TextEditingController();

  final _placeInputController = TextEditingController();

  final _dateInputController  = TextEditingController();

  final _notesInputController = TextEditingController();
 
  DateTime? _pickedDateTime;

  @override
  void initState() {
    _pickedDateTime = DateTime.now();
    _dateInputController.text = DateTime.now().toString().substring(0, 10);
    super.initState();
  }


  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _pickedDateTime) {
      setState(() {
        _pickedDateTime = picked;
        _dateInputController.text = _pickedDateTime.toString().substring(0, 10);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
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

    return AppStyleCard(
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
            child: Text('Выберите файл', style: TextStyle(fontSize: 18),),
            style: AppButtonStyle.textRoundedButton,
          ),
        ],
      ),
    );
  }
}
