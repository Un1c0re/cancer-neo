
import 'package:equatable/equatable.dart';

class Symptom extends Equatable {
  final String  name;
  final String  year;
  final String  month;
  final String  day;
  final int     value;

  const Symptom({
    required this.name, 
    required this.year, 
    required this.month, 
    required this.day, 
    required this.value
  }) : super();
  

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
