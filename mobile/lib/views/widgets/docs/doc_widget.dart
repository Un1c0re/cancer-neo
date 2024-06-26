import 'package:cancerneo/helpers/datetime_helpers.dart';
import 'package:cancerneo/helpers/get_helpers.dart';
import 'package:cancerneo/models/docs_models.dart';
import 'package:cancerneo/services/database_service.dart';
import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/utils/app_style.dart';
import 'package:cancerneo/utils/app_widgets.dart';
import 'package:cancerneo/views/screens/doc/edit_doc_screen.dart';
import 'package:cancerneo/views/screens/docview/docview_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';

class DocWidget extends StatefulWidget {
  final int docID;
  final Function onUpdate;
  const DocWidget({
    super.key,
    required this.docID,
    required this.onUpdate,
  });

  @override
  State<DocWidget> createState() => _DocWidgetState();
}

class _DocWidgetState extends State<DocWidget> {
  @override
  Widget build(BuildContext context) {
    final DatabaseService databaseService = Get.find();

    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: DeviceScreenConstants.screenHeight * 0.75,
                child: AppStyleCard(
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: DocDataWidget(
                      docID: widget.docID,
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
                        onPressed: () async {
                          await databaseService.database.docsDao
                              .deleteDoc(id: widget.docID);
                          deleteAction('Документ удален');
                          widget.onUpdate();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Удалить',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: AppButtonStyle.filledRoundedButton,
                        onPressed: () => Get.to(EditDocScreen(
                            docID: widget.docID, onUpdate: widget.onUpdate)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Изменить',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DocDataWidget extends StatefulWidget {
  final int docID;

  const DocDataWidget({
    super.key,
    required this.docID,
  });

  @override
  State<DocDataWidget> createState() => _DocDataWidgetState();
}

class _DocDataWidgetState extends State<DocDataWidget> {
  @override
  Widget build(BuildContext context) {
    final DatabaseService service = Get.find();
    late final String typeName;

    Future<DocModel?> getDocument(id) async {
      final DocModel? document = await service.database.docsDao.getDoc(id);
      typeName =
          await service.database.doctypesDao.getDocType(document!.type_id);
      return document;
    }

    return FutureBuilder(
      future: getDocument(widget.docID),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.activeColor,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final DocModel document = snapshot.data!;
          return SizedBox(
            height: DeviceScreenConstants.screenHeight * 0.5,
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(typeName,
                      style: const TextStyle(
                          fontSize: 18, fontStyle: FontStyle.italic)),
                  const SizedBox(height: 10),
                  const Text(
                    'Дата оформления документа:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    customFormat
                        .format(document.date)
                        .toString()
                        .substring(0, 10),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Учреждение:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    document.place,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Примечания:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    document.notes,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  if (document.file != null)
                    Center(child: _DocMiniature(document.file)),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}

class _DocMiniature extends StatelessWidget {
  final String? filePath;
  const _DocMiniature(this.filePath);

  Future<void> _openPdf(String filePath) async {
    Get.to(() => PdfViewerScreen(filePath: filePath));
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 120,
        maxWidth: 250,
      ),
      child: Stack(
        children: [
          const AppStyleCard(
            backgroundColor: AppColors.activeColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.description_rounded,
                  size: 70,
                  color: Colors.white,
                ),
                Text(
                  'Просмотреть документ',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => filePath != null ? _openPdf(filePath!) : {},
              overlayColor:
                  const MaterialStatePropertyAll(AppColors.overlayColor),
              splashColor: AppColors.splashColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
