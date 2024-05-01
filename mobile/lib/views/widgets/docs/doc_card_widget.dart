import 'package:diplom/helpers/datetime_helpers.dart';
import 'package:diplom/models/doc_list_model.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:diplom/views/screens/doc/doc_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocCardWidget extends StatefulWidget {
  final DocSummaryModel data;
  final Function onUpdate;
  final int docID;

  const DocCardWidget({
    super.key,
    required this.data,
    required this.onUpdate,
    required this.docID,
  });

  @override
  State<DocCardWidget> createState() => _DocCardWidgetState();
}

class _DocCardWidgetState extends State<DocCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppStyleCard(
          backgroundColor: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.data.name,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  customFormat
                      .format(widget.data.date)
                      .toString()
                      .substring(0, 10),
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
            onTap: () => Get.to(() => DocScreen(
                  docID: widget.docID,
                  onUpdate: widget.onUpdate,
                )),
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
