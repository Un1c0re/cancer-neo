import 'package:cancerneo/utils/app_colors.dart';
import 'package:cancerneo/utils/app_icons.dart';
import 'package:cancerneo/views/widgets/home/home_docs_wiget.dart';
import 'package:cancerneo/views/widgets/home/home_neo_widget.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_style_icons.dart';
import '../../widgets/home/home_charts_widget.dart';
import '../../widgets/home/home_profile_widget.dart';
import '../../widgets/home/home_symptoms_widget.dart';

class NavContent {
  final String title;
  final IconData icon;

  NavContent(
    this.title,
    this.icon,
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 1;
  static const List<String> titles = [
    'Документы',
    'Динамика',
    'Контроль',
    'Все о НЭО',
    'Профиль',
  ];

  static final List<Widget> _widgetTabs = <Widget>[
    HomeDocsWidget(appBarTitle: titles[0]),
    HomeChartsWidget(appBarTitle: titles[1]),
    SymptomsWidget(appBarTitle: titles[2]),
    const HomeNeoWidget(),
    HomeProfileWidget(appBarTitle: titles[4]),
  ];

  static final List<NavContent> content = [
    NavContent(titles[0], AppIcons.file),
    NavContent(titles[1], AppStyleIcons.leaderboard),
    NavContent(titles[2], AppIcons.heart),
    NavContent(titles[3], AppIcons.lightbulb),
    NavContent(titles[4], AppStyleIcons.user_alt),
  ];

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const selectedColor = AppColors.passiveColor;
    const iconColor = AppColors.activeColor;

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        surfaceTintColor: Colors.white,
        indicatorColor: selectedColor,
        destinations: content.map((data) {
          return NavigationDestination(
            icon: Icon(data.icon, color: iconColor),
            label: data.title,
          );
        }).toList(),
        selectedIndex: _selectedTab,
        onDestinationSelected: onSelectTab,
      ),
      body: _widgetTabs[_selectedTab],
    );
  }
}
