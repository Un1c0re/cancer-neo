class UserBar {

  final int x;
  final double y;

  const UserBar({
    required this.x,
    required this.y,
  });
}

class BarData {
  final double day1Amount;
  final double day2Amount;
  final double day3Amount;
  final double day4Amount;
  final double day5Amount;
  final double day6Amount;
  final double day7Amount;

  BarData({
    required this.day1Amount,
    required this.day2Amount,
    required this.day3Amount,
    required this.day4Amount,
    required this.day5Amount,
    required this.day6Amount,
    required this.day7Amount,
  });

  List<UserBar> barData = [];

  void initializeData() {
    barData = [
      UserBar(x: 0, y: day1Amount),
      UserBar(x: 1, y: day2Amount),
      UserBar(x: 2, y: day3Amount),
      UserBar(x: 3, y: day4Amount),
      UserBar(x: 4, y: day5Amount),
      UserBar(x: 5, y: day6Amount),
      UserBar(x: 6, y: day7Amount),
    ];
  }
}