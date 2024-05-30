import 'dart:ui';

class Task {
  final String title;
  final String note;
  final String dateTime;
  late String? time;
  late Color? color;
  final DateTime date;
  late int? priority;

  Task({
    required this.title,
    required this.note,
    required this.dateTime,
    required this.date,
     this.time,
    this.color,
    this.priority
  });
}
