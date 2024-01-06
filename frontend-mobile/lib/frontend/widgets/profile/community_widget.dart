import 'package:diplom/frontend/Theme/app_colors.dart';
import 'package:diplom/frontend/Theme/app_widgets.dart';
import 'package:flutter/material.dart';


class CommunityData {
  final IconData  icon;
  final String    title;
  final String    subtitle;

  CommunityData({
    required this.icon,
    required this.title,
    required this.subtitle,
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
      icon: Icons.album, 
      title: 'Нейроэндокринные опухоли - сообщество пациентов', 
      subtitle: 'Сообщество взаимопомощи пациентам с нейроэндокринными опухолями - НЭО в структуре Всероссийского общества редких (орфанных) заболеваний-ВООЗ.',
    ),
    CommunityData(
      icon: Icons.album, 
      title: 'Нейроэндокринные опухоли - сообщество пациентов', 
      subtitle: 'Сообщество взаимопомощи пациентам с нейроэндокринными опухолями - НЭО в структуре Всероссийского общества редких (орфанных) заболеваний-ВООЗ.',
    ),
    CommunityData(
      icon: Icons.album, 
      title: 'Нейроэндокринные опухоли - сообщество пациентов', 
      subtitle: 'Сообщество взаимопомощи пациентам с нейроэндокринными опухолями - НЭО в структуре Всероссийского общества редких (орфанных) заболеваний-ВООЗ.',
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
                icon: content.icon, 
                title: content.title, 
                subtitle: content.subtitle,
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
  final IconData  icon;
  final String    title;
  final String    subtitle;
  
  const CommunityCard({
    super.key, 
    required this.icon,
    required this.title, 
    required this.subtitle, 
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
            child: ListTile(
              leading:  Icon(icon),
              title:    Text(title, 
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text(subtitle,
                style: const TextStyle(fontSize: 18)),
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
        ]
      ),
    );
  }
}