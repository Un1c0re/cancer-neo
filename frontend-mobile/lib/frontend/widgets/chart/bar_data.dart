class SymptomeData {
  final List<double> values;
  final String name;
  final bool isBoolean;

  SymptomeData({
    required this.isBoolean,
    required this.values,
    required this.name,
  });
}


class SymptomeBarData {
  List<SymptomeData> symptomeData = [];

  void initializeData() {
    symptomeData = [
    SymptomeData(
        values: [0, 1, 0, 2, 2, 1, 0],
        name: 'Слабость, утомляемость',
        isBoolean: false),
    SymptomeData(
        values: [1, 1, 2, 0, 3, 3, 1],
        name: 'Болевой синдром',
        isBoolean: false),
    SymptomeData(
        values: [0, 1, 0, 1, 2, 1, 3],
        name: 'Депрессия, тревога',
        isBoolean: false),
    SymptomeData(
        values: [2, 3, 1, 1, 1, 1, 0],
        name: 'Мигрень',
        isBoolean: false),
    SymptomeData(
        values: [0, 1, 0, 1, 0, 0, 1], 
        name: 'Рвота', 
        isBoolean: true),
    SymptomeData(
        values: [0, 1, 0, 1, 0, 0, 1],
        name: 'Уменьшение диуреза',
        isBoolean: true),
    SymptomeData(
        values: [1, 1, 1, 0, 1, 1, 1],
        name: 'Ухудшение памяти',
        isBoolean: true),
    SymptomeData(
        values: [0, 1, 0, 1, 1, 1, 0],
        name: 'Нарушение моторных функций',
        isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0], name: 'Хрипы', isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0],
        name: 'Бронхоспазм',
        isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0],
        name: 'Боль в левой части грудной клетки',
        isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0],
        name: 'Аритмия',
        isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0],
        name: 'Спутанность сознания (химический мозг)',
        isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0],
        name: 'Спутанность сознания (прилив жара к верхней части туловища)',
        isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0],
        name: 'Нейродермит (сыпь, зуд)',
        isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0],
        name: 'Стоматит',
        isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0],
        name: 'Невропатия руки',
        isBoolean: true),
    SymptomeData(
        values: [1, 0, 0, 0, 0, 1, 0],
        name: 'Невропатия ноги',
        isBoolean: true),
    ];
  }
}