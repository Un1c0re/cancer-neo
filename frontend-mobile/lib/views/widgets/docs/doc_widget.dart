 import 'dart:typed_data';

import 'package:diplom/helpers/get_helpers.dart';
import 'package:diplom/models/docs_models.dart';
import 'package:diplom/services/database_service.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_style.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/views/screens/doc/edit_doc_screen.dart';
import 'package:diplom/views/screens/pdfview/pdfview_screen.dart';
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
                              .deleteDoc(docID: widget.docID);
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
                        onPressed: () => Get.to(
                            EditDocScreen(docID: widget.docID, onUpdate: widget.onUpdate)),
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
      typeName = await service.database.doctypesDao.getDocType(document!.docType);
      return document;
    }

    Future<String>getDocTypeName(typeID) async {
      return await service.database.doctypesDao.getDocType(typeID);
    }

    return FutureBuilder(
      future: getDocument(widget.docID),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final DocModel document = snapshot.data!;
          return SizedBox(
            height: DeviceScreenConstants.screenHeight * 0.5,
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document.docName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'тип документа',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(typeName),
                const SizedBox(height: 10),
                const Text(
                  'Дата оформления документа:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  document.docDate.toString().substring(0, 10),
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
                  document.docPlace,
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
                  document.docNotes,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                if (document.pdfFile != null) _DocMiniature(document.pdfFile),
              ],
            ),
          );
        }
      }),
    );
  }
}

class _DocMiniature extends StatelessWidget {
  final Uint8List? pdfBytes;
  const _DocMiniature(this.pdfBytes);

  Future<void> _openPdf(Uint8List pdfBytes) async {
    Get.to(() => PdfViewerScreen(pdfBytes: pdfBytes));
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 70,
        maxWidth: 70,
      ),
      child: Stack(
        children: [
          const AppStyleCard(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.description_rounded,
              size: 40,
              color: AppColors.activeColor,
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => pdfBytes != null ? _openPdf(pdfBytes!) : {},
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
