import 'package:diplom/bloc/document_bloc.dart';
import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_icons.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_style_icons.dart';
import '../../widgets/chart/chart_widget.dart';
import '../../widgets/docs/docs_list_widget.dart';
import '../../widgets/info/info_widget.dart';
import '../../widgets/profile/profile_widget.dart';
import '../../widgets/symptoms/symptoms_widget.dart';


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

	static final List<Widget> _widgetTabs = <Widget>[
		const ChartWidget(),
    const SymptomsWidget(),
		const DocsListWidget(),
		const InfoWiget(),
		const SettingsWidget(),
	];

  static final List<NavContent> content = [
    NavContent('Трекинг', AppStyleIcons.leaderboard),
    NavContent('Данные', AppIcons.heart),
    NavContent('Архив', AppIcons.file),
    NavContent('Инфо', AppIcons.lightbulb),
    NavContent('Другое', AppIcons.bookmark),
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
		const iconColor     = AppColors.activeColor;

		return Scaffold(
			bottomNavigationBar: NavigationBar(
        surfaceTintColor: Colors.white,
			  indicatorColor: selectedColor,

        destinations: content.map(
          (data) {
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
