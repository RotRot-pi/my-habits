import 'dart:convert';

import 'package:flutter/material.dart';

class Habit {
  String name;
  String? description;
  Color? color;
  bool isCompleted;
  DateTime firstDate;
  Habit({
    required this.name,
    this.description,
    this.color,
    required this.isCompleted,
    required this.firstDate,
  });

  Habit copyWith({
    String? name,
    String? description,
    Color? color,
    bool? isCompleted,
    DateTime? firstDate,
  }) {
    return Habit(
      name: name ?? this.name,
      description: description ?? this.description,
      color: color ?? this.color,
      isCompleted: isCompleted ?? this.isCompleted,
      firstDate: firstDate ?? this.firstDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'color': color?.value,
      'isCompleted': isCompleted,
      'firstDate': firstDate.millisecondsSinceEpoch,
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      color: map['color'] != null ? Color(map['color']) : null,
      isCompleted: map['isCompleted'] ?? false,
      firstDate: DateTime.fromMillisecondsSinceEpoch(map['firstDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Habit.fromJson(String source) => Habit.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Habit(name: $name,description:$description, color: $color, isCompleted: $isCompleted, firstDate: $firstDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Habit &&
        other.name == name &&
        other.description == description &&
        other.color == color &&
        other.isCompleted == isCompleted &&
        other.firstDate == firstDate;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        color.hashCode ^
        isCompleted.hashCode ^
        firstDate.hashCode;
  }
}
