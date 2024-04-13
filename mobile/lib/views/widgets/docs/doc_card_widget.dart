import 'package:diplom/helpers/datetime_helpers.dart';
import 'package:diplom/models/doc_list_model.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_icons.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/views/screens/doc/doc_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocCardWidget extends StatefulWidget {
  final DocSummaryModel data;
  final Function onUpdate;

  const DocCardWidget({
    super.key,
    required this.data,
    required this.onUpdate,
  });

  @override
  State<DocCardWidget> createState() => _DocCardWidgetState();
}

class _DocCardWidgetState extends State<DocCardWidget> {
  void _getDocScreen(docId) =>
      Get.to(() => DocScreen(docID: docId, onUpdate: widget.onUpdate));

  Icon _getTypeIcon(typeID) {
    switch (typeID) {
      case 0:
        return const Icon(AppIcons.lightbulb);
      case 1:
        return const Icon(AppIcons.capsules);
      case 2:
        return const Icon(AppIcons.dna);
      case 3:
        return const Icon(AppIcons.clock);
      default:
        return const Icon(Icons.error, color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppStyleCard(
          backgroundColor: Colors.white,
          child: Row(
            children: [
              _getTypeIcon(widget.data.docType),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  widget.data.docName,
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
                  customFormat.format(widget.data.docDate).toString().substring(0, 10),
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
            onTap: () => _getDocScreen(widget.data.id),
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
