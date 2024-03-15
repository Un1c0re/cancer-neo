import 'package:diplom/models/docs_models.dart';
import 'package:diplom/services/database_service.dart';
import 'package:diplom/utils/app_colors.dart';
// import 'package:diplom/utils/app_icons.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../utils/app_style.dart';
import '../../../utils/constants.dart';
import '../../screens/doc/add_doc_screen.dart';
import '../../screens/doc/doc_screen.dart';

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

class DocsListWidget extends StatefulWidget {
  const DocsListWidget({super.key});

  @override
  State<DocsListWidget> createState() => _DocsListWidgetState();
}

class _DocsListWidgetState extends State<DocsListWidget> {
  var _filteredData = <DocSummary>[];

  final DateRangePickerController _pickerController =
      DateRangePickerController();
  PickerDateRange? _selectedRange;

  void _addDocOrDiary() {
    Get.to(() => const AddDocScreen());
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

  void _setList() {
    if (_selectedRange?.startDate != null) {
      var dateStart = _selectedRange!.startDate;
      var dateEnd = _selectedRange!.endDate;
      _filteredData = _filteredData.where((DocSummary data) {
        return (!data.docDate.isBefore(dateStart!) &&
            !data.docDate.isAfter(dateEnd!));
      }).toList();
    }
    setState(() {});
  }

  Future _showCalendar(BuildContext context) {
    return showDialog<DateRangePickerController>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 400,
              width: 400,
              child: Theme(
                data: ThemeData(),
                child: SfDateRangePicker(
                    selectionColor: AppColors.activeColor,
                    startRangeSelectionColor: AppColors.activeColor,
                    endRangeSelectionColor: AppColors.activeColor,
                    confirmText: 'Подтвердить',
                    cancelText: 'Отменить',
                    view: DateRangePickerView.month,
                    controller: _pickerController,
                    selectionMode: DateRangePickerSelectionMode.range,
                    showActionButtons: true,
                    onCancel: () => {
                          _selectedRange = null,
                          _setList(),
                          Navigator.of(context).pop()
                        },
                    onSubmit: (dates) => {
                          _setList(),
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

    Future<List<DocSummary>> getDocs() async {
      return await databaseService.database.docsDao.getAllDocSummaries();
    }

    return Scaffold(
      appBar: AppBar(
        title: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 250,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  style: const ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  onPressed: () => _showCalendar(context),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.calendar_today_outlined),
                      Text(
                        'Отфильтровать по дате',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: DeviceScreenConstants.screenHeight * 0.70,
                child: FutureBuilder<List<DocSummary>>(
                    future: getDocs(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final List<DocSummary> docsList = snapshot.data!;
                        _filteredData = docsList;

                        return ListView.builder(
                            itemCount: docsList.length,
                            itemExtent: 80,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child:
                                    _DocsWidgetRow(data: docsList[index]),
                              );
                            });
                      }
                    }))),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 45,
                maxWidth: 300,
              ),
              child: Center(
                child: ElevatedButton(
                  style: AppButtonStyle.basicButton,
                  onPressed: _addDocOrDiary,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_outlined),
                      SizedBox(width: 5),
                      Text(
                        'Добавить',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

class _DocsWidgetRow extends StatelessWidget {
  final DocSummary data;

  const _DocsWidgetRow({
    required this.data,
  });

  void _getDocScreen(docId) => Get.to(() => DocScreen(docID: docId,));

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppStyleCard(
          backgroundColor: Colors.white,
          child: Row(
            children: [
              Icon(Icons.document_scanner_outlined),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  data.docName,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  data.docDate.toString().substring(0, 10),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blueGrey.shade300,
                  ),
                ),
              ),
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _getDocScreen(data.id),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            overlayColor:
                const MaterialStatePropertyAll(AppColors.overlayColor),
            splashColor: AppColors.splashColor,
          ),
        )
      ],
    );
  }
}
