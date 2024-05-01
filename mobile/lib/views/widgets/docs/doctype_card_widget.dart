import 'package:cancerneo/models/doc_type_model.dart';
import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/utils/app_widgets.dart';
import 'package:cancerneo/views/screens/doc/doc_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocTypeCardWidget extends StatefulWidget {
  final DoctypeModel data;

  const DocTypeCardWidget({
    super.key,
    required this.data,
  });

  @override
  State<DocTypeCardWidget> createState() => _DocTypeCardWidgetState();
}

class _DocTypeCardWidgetState extends State<DocTypeCardWidget> {
    
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppStyleCard(
          backgroundColor: Colors.white,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.data.name,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 18,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => Get.to(() => DocsListScreen(doctype: widget.data)),
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
