import 'package:cancerneo/helpers/datetime_helpers.dart';
import 'package:cancerneo/models/doc_list_model.dart';
import 'package:cancerneo/models/doc_type_model.dart';
import 'package:cancerneo/services/database_service.dart';
import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/views/widgets/docs/doc_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../utils/constants.dart';
import '../../screens/doc/add_doc_screen.dart';

class DocsListScreen extends StatefulWidget {
  final DoctypeModel doctype;
  const DocsListScreen({
    super.key,
    required this.doctype,
  });

  @override
  State<DocsListScreen> createState() => _DocsListScreenState();
}

class _DocsListScreenState extends State<DocsListScreen> {
  var _filteredData = <DocSummaryModel>[];

  final DateRangePickerController _pickerController =
      DateRangePickerController();
  PickerDateRange? _selectedRange;

  void _updateData() {
    setState(() {});
  }

  void _addDoc() {
    Get.to(() => AddDocScreen(onUpdate: _updateData, doctype: widget.doctype));
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseService databaseService = Get.find();

    Future<List<DocSummaryModel>> getDocs(typeID) async {
      return await databaseService.database.docsDao
          .getDocSummariesByTypeID(typeID);
    }

    return Scaffold(
      appBar: AppBar(
        title: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: DeviceScreenConstants.screenWidth * 0.9,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 170,
                ),
                child: Text(
                  widget.doctype.name,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 100),
                child: Row(
                  children: [
                    IconButton(
                      style: const ButtonStyle(
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                      ),
                      onPressed: () =>
                          selectDateRange(context, _pickerController, _updateData),
                      icon: const Icon(Icons.calendar_today_outlined),
                    ),
                    IconButton(
                      style: const ButtonStyle(
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
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
            future: getDocs(widget.doctype.id),
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
                    return (!data.date.isBefore((_selectedRange!.startDate!)) &&
                        !data.date.isAfter(_selectedRange!.endDate!));
                  }).toList();
                } else {
                  _filteredData = docListData;
                }
                if (_filteredData.isEmpty) {
                  return const Center(
                    child: Text(
                      'Вы еще не добавили ни одного документа',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        color: AppColors.activeColor,
                      ),
                    ),
                  );
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
                          docID: _filteredData[index].id,
                        ),
                      );
                    });
              }
            }),
          ),
        ),
      ),
    );
  }
}
