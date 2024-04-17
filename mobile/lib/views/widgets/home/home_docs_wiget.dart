import 'package:diplom/models/doc_type_model.dart';
import 'package:diplom/services/database_service.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/constants.dart';
import 'package:diplom/views/widgets/docs/doctype_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeDocsWidget extends StatefulWidget {
  final String appBarTitle;
  const HomeDocsWidget({
    super.key,
    required this.appBarTitle,
  });

  @override
  State<HomeDocsWidget> createState() => _HomeDocsWidgetState();
}

class _HomeDocsWidgetState extends State<HomeDocsWidget> {
  final DatabaseService service = Get.find();

  Future<List<DoctypeModel>> getDocTypes() async {
    return await service.database.doctypesDao.getAllDocTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: DeviceScreenConstants.screenWidth * 0.9,
          ),
          child: Center(
            child: Text(
              widget.appBarTitle,
              style: const TextStyle(fontSize: 26),
            ),
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
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: DeviceScreenConstants.screenHeight),
            child: FutureBuilder<List<DoctypeModel>>(
              future: getDocTypes(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.activeColor),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final List<DoctypeModel> doctypes = snapshot.data!;
                  return ListView.builder(
                      itemCount: doctypes.length,
                      itemExtent: 80,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: DocTypeCardWidget(
                            data: doctypes[index],
                          ),
                        );
                      });
                }
              }),
            ),
          ),
        ),
      ),
    );
  }
}
