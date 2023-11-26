import 'package:flutter/material.dart';

import '../../Theme/app_style.dart';
import '../../Theme/constants.dart';


class DocData {
  final String label;
  final String type;
  final String datetime;
  final String place;
  final String description;

  DocData(
    this.label,
    this.type,
    this.datetime,
    this.place,
    this.description,
  );
}

class DocWidget extends StatelessWidget {
  DocWidget({super.key});

  final docData = DocData(
    'Результаты Рентгенографии',
    'рентген',
    '12.12.2022', 
    'БУ Сургутская клиническая травмотологическая больница', 
    'Делал Рентгенографию грудной клетки на выявление наличия новообразований. Результат оказался отрицательным',
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: DeviceScreenConstants.screenHeight * 0.6,

          child: AppStyleCard(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DocDataWidget(docData: docData),
                ],
              ),
            ), 
          ),
        ),
      ],
    );
  }
}

class DocDataWidget extends StatelessWidget {
  const DocDataWidget({
    super.key,
    required this.docData,
  });

  final DocData docData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DeviceScreenConstants.screenHeight * 0.5,
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            docData.label, 
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
            
          Text(
            docData.type,
            style: const TextStyle(fontSize: 18),
          ),

          const SizedBox(height: 10),
          
          Text(
            'Дата оформления документа:', 
            style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            docData.datetime,
            style: const TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),

          Text(
            'Учреждение:', 
            style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold,
            ),
          ),
            
          Text(
            docData.place,
            style: const TextStyle(fontSize: 18),
          ),

          const SizedBox(height: 12),
          Text(
            'Примечания:', 
            style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold,
            ),
          ),
          
           Text(
            docData.description,
            style: const TextStyle(fontSize: 16),
          ),

          const _DocMiniature(),
        ],
      ),
    );
  }
}

class _DocMiniature extends StatelessWidget {
  const _DocMiniature({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 70,
        maxWidth: 70,
      ),
      
      child: Stack(
        children: [
          const AppStyleCard (
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
            onTap: () {},
            overlayColor: const MaterialStatePropertyAll(AppColors.overlayColor),
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