import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/utils/app_widgets.dart';
import 'package:cancerneo/views/screens/webview/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityData {
  final String image;
  final String title;
  final String description;
  final String url;

  CommunityData({
    required this.image,
    required this.title,
    required this.description,
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
      image: 'assets/images/community/peer_school.png',
      title: 'Равные консультанты',
      description: 'Проект благотворительной программы "Женское здоровье.',
      url: 'https://rk-onco.ru/'
    ),
    CommunityData(
      image: 'assets/images/community/cancerneo.png',
      title: 'Нейроэндокринные опухоли - сообщество пациентов',
      description: 'Взаимопомощь пациентам с НЭО в структуре ВООЗ.',
      url: 'https://vk.com/cancerneo'
    ),
    CommunityData(
      image: 'assets/images/community/admin_league.png',
      title: 'Лига админов',
      description: 'Пациентские онкосообщества по нозологиям, городам и другим фильтрам.',
      url: 'https://taplink.cc/ligaadminov'
    ),
    CommunityData(
      image: 'assets/images/community/admin_league.png',
      title: 'Лига админов - НКО',
      description: 'Организации, помогающие онкопациентам.',
      url: 'https://taplink.cc/ligaadminov_nko'
    ),
    CommunityData(
      image: 'assets/images/community/onkoheroes.png',
      title: 'Онкогерои',
      description: 'Сообщество пациентов и помогающих организаций.',
      url: 'https://vk.com/onco_patients'
    ),
    CommunityData(
      image: 'assets/images/community/curable.png',
      title: 'Рак излечим',
      description: 'Общественное движение',
      url: 'https://vk.com/netonco'
    ),
    CommunityData(
      image: 'assets/images/community/oncotv.png',
      title: 'ONCO TV',
      description: 'Канал с видеороликами об онкологии.',
      url: 'https://www.youtube.com/@oncotv3779'
    ),
    CommunityData(
      image: 'assets/images/community/oncologica.png',
      title: 'Онкологика',
      description: 'Благотворительный фонд.',
      url: 'https://oncologica.ru/'
    ),
    CommunityData(
      image: 'assets/images/community/oncoguide.png',
      title: 'Онконавигатор',
      description: 'Дорожные карты в помощь онкологическим пациентам и их родным.',
      url: 'https://oncoguide.ru/'
    ),
    CommunityData(
      image: 'assets/images/community/yasnoe_utro.png',
      title: 'Ясное утро',
      description: 'Круглосуточная поддержка в борьбе с раком.',
      url: 'https://yasnoeutro.ru/'
    ),
    CommunityData(
      image: 'assets/images/community/chemical.png',
      title: 'Химия была, но мы расстались',
      description: 'Всероссийский проект по поддержке людей с онкологическими заболеваниями.',
      url: 'https://myphototherapy.ru/'
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: data
            .map(
              (community) => Column(
                children: [
                  CommunityCard(
                    image: community.image,
                    title: community.title,
                    description: community.description,
                    url: community.url,
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

class CommunityCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String url;

  const CommunityCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 280,
      ),
      child: Stack(children: [
        AppStyleCard(
          backgroundColor: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(image, width: 100),
              Text(title,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              Text(description,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                  ))
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Get.to(() => WebViewScreen(url: url));
            },
            overlayColor:
                const MaterialStatePropertyAll(AppColors.overlayColor),
            splashColor: AppColors.splashColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ]),
    );
  }
}
