part of 'symptoms_bloc.dart';

@immutable
abstract class SymptomsEvent extends Equatable {
  const SymptomsEvent();

  @override
  List<Object> get props => [];
}

class AddSymptoms extends SymptomsEvent {
  final String name;
  final String year;
  final String month;
  final String day;
  final int value;

  const AddSymptoms({
    required this.name, 
    required this.year, 
    required this.month,
    required this.day,
    required this.value,
  });

  @override
  List<Object> get props => [
    name, 
    year, 
    month, 
    day, 
    value,
  ];
}

class UpdateSymptoms extends SymptomsEvent {
  final String symptomId;
  final int newValue;

  const UpdateSymptoms({
    required this.symptomId,
    required this.newValue,
  });

  @override
  List<Object> get props => [
    symptomId,
    newValue,
  ];
}