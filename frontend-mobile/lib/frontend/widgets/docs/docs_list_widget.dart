import 'package:diplom/frontend/Theme/app_colors.dart';
import 'package:diplom/frontend/Theme/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../Theme/app_style.dart';
import '../../Theme/constants.dart';
import '../../screens/doc/add_doc_screen.dart';
import '../../screens/doc/doc_screen.dart';

class DocsRowData {
  final IconData icon;
  final String label;
  final DateTime datetime;

  DocsRowData(this.icon, this.label, this.datetime);
}


class DocsListWidget extends StatefulWidget {
  const DocsListWidget({super.key});

  @override
  State<DocsListWidget> createState() => _DocsListWidgetState();
}

class _DocsListWidgetState extends State<DocsListWidget> {
  final List<DocsRowData> docsRow = [
    DocsRowData(Icons.abc_outlined, 'Результаты анализов', DateTime.parse('2023-02-01')),
    DocsRowData(Icons.dangerous_outlined, 'Результаты рентгенографии', DateTime.parse('2023-01-02')),
    DocsRowData(Icons.computer_outlined, 'Результаты КТ', DateTime.parse('2023-03-02')),
    DocsRowData(Icons.badge_outlined, 'Результаты МРТ', DateTime.parse('2023-01-11')),
    DocsRowData(Icons.abc_outlined, 'Результаты анализов', DateTime.parse('2023-02-05')),
    DocsRowData(Icons.dangerous_outlined, 'Результаты рентгенографии', DateTime.parse('2023-11-01')),
    DocsRowData(Icons.computer_outlined, 'Результаты КТ', DateTime.parse('2023-01-21')),
    DocsRowData(Icons.badge_outlined, 'Результаты МРТ', DateTime.parse('2023-10-01')),
    DocsRowData(Icons.abc_outlined, 'Результаты анализов', DateTime.parse('2023-01-01')),
    DocsRowData(Icons.dangerous_outlined, 'Результаты рентгенографии', DateTime.parse('2023-01-01')),
    DocsRowData(Icons.computer_outlined, 'Результаты КТ', DateTime.parse('2023-01-01')),
    DocsRowData(Icons.badge_outlined, 'Результаты МРТ', DateTime.parse('2023-01-01')),
    DocsRowData(Icons.abc_outlined, 'Результаты анализов', DateTime.parse('2023-01-01')),
    DocsRowData(Icons.dangerous_outlined, 'Результаты рентгенографии', DateTime.parse('2023-01-01')),
    DocsRowData(Icons.computer_outlined, 'Результаты КТ', DateTime.parse('2023-01-01')),
    DocsRowData(Icons.badge_outlined, 'Результаты МРТ', DateTime.parse('2023-01-01')),
    DocsRowData(Icons.abc_outlined, 'Результаты анализов', DateTime.parse('2023-01-01')),
    DocsRowData(Icons.dangerous_outlined, 'Результаты рентгенографии', DateTime.parse('2023-01-01')),
    DocsRowData(Icons.computer_outlined, 'Результаты КТ', DateTime.parse('2023-01-01')),
    DocsRowData(Icons.badge_outlined, 'Результаты МРТ', DateTime.parse('2023-01-01')),
    DocsRowData(Icons.abc_outlined, 'Результаты анализов', DateTime.parse('2023-01-01')),
    DocsRowData(Icons.dangerous_outlined, 'Результаты рентгенографии', DateTime.parse('2023-01-01')),
    DocsRowData(Icons.computer_outlined, 'Результаты КТ', DateTime.parse('2023-01-01')),
    DocsRowData(Icons.badge_outlined, 'Результаты МРТ', DateTime.parse('2023-01-01')),
  ];

  var _filteredData     = <DocsRowData>[];
  
  final DateRangePickerController _pickerController = DateRangePickerController();
  PickerDateRange? _selectedRange;

  void _addDocOrDiary() {
    Get.to(()=> const AddDocScreen());
  }

  @override
  void initState() {
    _pickerController.selectedRange = PickerDateRange(
      DateTime.now(),
      DateTime.now().add(const Duration(days: 10)),
    );
    _pickerController.displayDate = DateTime.now();
    _pickerController.addPropertyChangedListener(handlePropertyChange);
    _filteredData = docsRow; 
    super.initState();
  }

  void handlePropertyChange(String propertyName) {
    if (propertyName == 'selectedRange') {
      _selectedRange = _pickerController.selectedRange;
    }
  }

  void _setList () {
    if (_selectedRange?.startDate != null) {
      var dateStart = _selectedRange!.startDate;
      var dateEnd   = _selectedRange!.endDate;
      _filteredData = docsRow.where(
        (DocsRowData data) {
          return (
            !data.datetime.isBefore(dateStart!) &&
            !data.datetime.isAfter(dateEnd!)
          );}).toList();
    } else {
      _filteredData = docsRow;
    }
    setState(() {});
  }

  Future _showCalendar(BuildContext context) {
    return showDialog<DateRangePickerController>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 400,
            width: 400,
            child: Theme(
              data: ThemeData(
                useMaterial3: true,
                colorScheme: const ColorScheme.light(
                  brightness: Brightness.light,
                  primary: AppColors.activeColor,
                  onPrimary: Colors.white,
                  secondary: AppColors.secondaryColor,
                  onSecondary: Colors.white,
                  error: Colors.red,
                  onError: Colors.white,
                )
              ),
              child: SfDateRangePicker(
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
                }
              ),
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 40,
            maxWidth: 150,
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: AppButtonStyle.dateButton,
                  onPressed: () => _showCalendar(context),
                  child: const Icon(Icons.calendar_today_outlined),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: DeviceScreenConstants.screenHeight * 0.65,
          child: _filteredData.isNotEmpty
            ? ListView.builder(
                itemCount: _filteredData.length,
                itemExtent: 80,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: _DocsWidgetRow(data: _filteredData[index]),
                  );
                }
              )
            : const Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                  child: Text('Вы еще не добавили ни одного документа', 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.activeColor,
                      fontSize: 25,
                    ),
                  ),
                ),
            ),
        ),

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
                  Text('Добавить',
                  style: TextStyle(
                    fontSize: 18,
                  ),),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class _DocsWidgetRow extends StatelessWidget {
  final DocsRowData data;

  const _DocsWidgetRow({
    required this.data,
  });

  void _getDocScreen () => Get.to(() => const DocScreen());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppStyleCard(
          backgroundColor: Colors.white,
          
          child: Row(
            children: [
              Icon(data.icon),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  data.label,
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
                  data.datetime.toString().substring(0, 10), 
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
            onTap: _getDocScreen,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            overlayColor: const MaterialStatePropertyAll(AppColors.overlayColor),
            splashColor: AppColors.splashColor,
          ),
        )
      ],
    );
  }
}
