import 'package:diplom/frontend/Theme/app_colors.dart';
import 'package:diplom/frontend/Theme/app_widgets.dart';
import 'package:diplom/frontend/screens/webview/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityData {
  final String    image;
  final String    title;
  final String    subtitle;
  final String    url;

  CommunityData({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.url,
  });
}


class CommunityWidget extends StatefulWidget {
  const CommunityWidget({super.key});

  @override
  State<CommunityWidget> createState() => _CommunityWidgetState();
}

class _CommunityWidgetState extends State<CommunityWidget> {
  final List<CommunityData> data = [
    CommunityData(
      image: 'assets/images/neo1.png', 
      title: 'Нейроэндокринные опухоли - сообщество пациентов', 
      subtitle: 'Взаимопомощь пациентам с НЭО в структуре Всероссийского общества редких (орфанных) заболеваний.',
      url: 'https://vk.com/cancerneo'
    ),
    CommunityData(
      image: 'assets/images/neo1.png', 
      title: 'Нейроэндокринные опухоли - сообщество пациентов', 
      subtitle: 'Взаимопомощь пациентам с НЭО в структуре Всероссийского общества редких (орфанных) заболеваний.',
      url: 'https://www.google.com'
    ),
    CommunityData(
      image: 'assets/images/neo1.png', 
      title: 'Нейроэндокринные опухоли - сообщество пациентов', 
      subtitle: 'Взаимопомощь пациентам с НЭО в структуре Всероссийского общества редких (орфанных) заболеваний.',
      url: 'https://www.example.com'
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: data.map((content) => 
          Column(
            children: [
              CommunityCard(
                image: content.image, 
                title: content.title, 
                subtitle: content.subtitle,
                url: content.url,
              ),
              const SizedBox(height: 15),
            ],
          ),
        ).toList(), 
      ),
    );
  }
}

class CommunityCard extends StatelessWidget {
  final String    image;
  final String    title;
  final String    subtitle;
  final String    url;
  
  const CommunityCard({
    super.key, 
    required this.image,
    required this.title, 
    required this.subtitle, 
    required this.url, 
  });
  
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 210,
      ),
      child: Stack(
        children:[ 
          AppStyleCard(
            backgroundColor: Colors.white, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(image, width: 100),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 255
                  ),
                  child: Column(
                    children: [
                      Text(
                        title, 
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 18,
                        )),
                    ],
                  ),
                )
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Get.to(() => WebViewScreen(url: url));
              },
              overlayColor: const MaterialStatePropertyAll(AppColors.overlayColor),
              splashColor: AppColors.splashColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        ]
      ),
    );
  }
}