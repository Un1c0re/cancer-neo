import 'package:diplom/models/doc_list_model.dart';
import 'package:diplom/services/database_service.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/views/widgets/docs/doc_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../utils/constants.dart';
import '../../screens/doc/add_doc_screen.dart';

class DocsListWidget extends StatefulWidget {
  const DocsListWidget({super.key});

  @override
  State<DocsListWidget> createState() => _DocsListWidgetState();
}

class _DocsListWidgetState extends State<DocsListWidget> {
  var _filteredData = <DocSummaryModel>[];

  final DateRangePickerController _pickerController =
      DateRangePickerController();
  PickerDateRange? _selectedRange;

  void _updateData() {
    setState(() {});
  }

  void _addDoc() {
    Get.to(() => AddDocScreen(onUpdate: _updateData));
  }

  @override
  void initState() {
    _pickerController.selectedRange = PickerDateRange(
      DateTime.now(),
      DateTime.now().add(const Duration(days: 10)),
    );
    _pickerController.displayDate = DateTime.now();
    _pickerController.addPropertyChangedListener(handlePropertyChange);
    _filteredData = [];
    super.initState();
  }

  void handlePropertyChange(String propertyName) {
    if (propertyName == 'selectedRange') {
      _selectedRange = _pickerController.selectedRange;
    }
  }

  Future _showCalendar(BuildContext context) {
    return showDialog<DateRangePickerController>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: const Color.fromRGBO(238, 243, 249, 1),
            surfaceTintColor: const Color.fromRGBO(238, 243, 249, 1),
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 500,
              width: 400,
              child: Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AppColors.primaryColor, // Цвет выбранной даты
                  colorScheme: const ColorScheme.light(
                    primary: AppColors.primaryColor, // Цветовая схема
                    onPrimary: Colors.white, // Цвет текста на выбранной дате
                    surface: Colors.white, // Цвет фона элементов
                    onSurface: Colors.black, // Цвет текста элементов
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          AppColors.activeColor, // Цвет текста кнопок
                    ),
                  ),
                ),
                child: SfDateRangePicker(
                    maxDate: DateTime.now(),
                    selectionColor: AppColors.primaryColor,
                    startRangeSelectionColor: AppColors.primaryColor,
                    endRangeSelectionColor: AppColors.primaryColor,
                    confirmText: 'Подтвердить',
                    cancelText: 'Сбросить',
                    view: DateRangePickerView.month,
                    controller: _pickerController,
                    selectionMode: DateRangePickerSelectionMode.range,
                    showActionButtons: true,
                    onCancel: () => {
                          _selectedRange = null,
                          setState(() {}),
                          Navigator.of(context).pop()
                        },
                    onSubmit: (dates) => {
                          setState(() {}),
                          Navigator.of(context).pop(),
                        }),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseService databaseService = Get.find();

    Future<List<DocSummaryModel>> getDocs() async {
      return await databaseService.database.docsDao.getAllDocSummaries();
    }

    return Scaffold(
      appBar: AppBar(
        title: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Документы',
                      style: TextStyle(fontSize: 28),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 100),
                      child: Row(
                        children: [
                          IconButton(
                            style: const ButtonStyle(
                              foregroundColor:
                                  MaterialStatePropertyAll(Colors.white),
                            ),
                            onPressed: () => _showCalendar(context),
                            icon: const Icon(Icons.calendar_today_outlined),
                          ),
                          IconButton(
                            style: const ButtonStyle(
                              foregroundColor:
                                  MaterialStatePropertyAll(Colors.white),
                            ),
                            onPressed: () => _addDoc(),
                            icon: const Icon(
                              Icons.add,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
            height: DeviceScreenConstants.screenHeight,
            child: FutureBuilder<List<DocSummaryModel>>(
                future: getDocs(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<DocSummaryModel> docListData = snapshot.data!;
                    if (_selectedRange?.startDate != null &&
                        _selectedRange?.endDate != null) {
                      _filteredData = docListData.where((DocSummaryModel data) {
                        return (!data.docDate
                                .isBefore((_selectedRange!.startDate!)) &&
                            !data.docDate.isAfter(_selectedRange!.endDate!));
                      }).toList();
                    } else {
                      _filteredData = docListData;
                    }
                    return ListView.builder(
                        itemCount: _filteredData.length,
                        itemExtent: 80,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: DocCardWidget(
                              data: _filteredData[index],
                              onUpdate: _updateData,
                            ),
                          );
                        });
                  }
                }))),
      ),
    );
  }
}
