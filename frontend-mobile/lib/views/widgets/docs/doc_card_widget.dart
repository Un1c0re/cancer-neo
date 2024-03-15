
import 'package:diplom/models/doc_list_model.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/views/screens/doc/doc_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocCardWidget extends StatelessWidget {
  final DocSummaryModel data;

  const DocCardWidget({
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
