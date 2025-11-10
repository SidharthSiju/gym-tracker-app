import 'package:uuid/uuid.dart';

final uuid = Uuid();

enum Groups { biceps, triceps, chest, shoulder, legs, abs, back, glutes }

class Exercise {
  Exercise({
    required this.name,
    this.sets = 0,
    this.reps = 0,
    this.weight = 0.0,
    this.duration = 0.0,
    required this.groups,
  }) : id = uuid.v4(),
       date = DateTime.now();

  final String name;
  DateTime date;
  String id;
  int sets;
  int reps;
  double weight;
  double duration;
  final Groups groups;

  void setSets(int value) {
    sets = value;
  }

  void setReps(int value) {
    reps = value;
  }

  void setWeight(double value) {
    weight = value;
  }

  void setDuration(double value) {
    duration = value;
  }
}
