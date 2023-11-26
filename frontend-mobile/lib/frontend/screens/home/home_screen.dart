import 'package:flutter/material.dart';
import '../../Theme/app_style_icons.dart';
import '../../widgets/chart/chart_widget.dart';
import '../../widgets/docs/docs_list_widget.dart';
import '../../Theme/app_style.dart';
import '../../widgets/info/info_widget.dart';
import '../../widgets/profile/profile_widget.dart';
import '../../widgets/stats/stats_widget.dart';


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
    const StatsWidget(),
		const DocsListWidget(),
		const InfoWiget(),
		const SettingsWidget(),
	];

  static final List<NavContent> content = [
    NavContent('Трекинг', AppStyleIcons.leaderboard),
    NavContent('Данные', AppStyleIcons.edit),
    NavContent('Архив', AppStyleIcons.docs),
    NavContent('Информация', AppStyleIcons.graduation_cap),
    NavContent('Профиль', AppStyleIcons.profile),
  ];

  static final List<Row> _appBarContent = content.map((data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(data.icon),
        const SizedBox(width: 15),
        Text(data.title),
      ],
    );
  }).toList();


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
			appBar: AppBar(
				title: _appBarContent[_selectedTab],
				centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
			),

			bottomNavigationBar: NavigationBar(
			  backgroundColor: Colors.white,
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

			body: Padding(
			  padding: const EdgeInsets.all(10.0),
			  child: _widgetTabs[_selectedTab],
			),
			);
	}
}
