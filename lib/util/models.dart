import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Task {
  @Id()
  int id;

  String identity;
  String name;
  int importancy;
  bool isFinished;
  int sortIndex;

  Task({
    this.id = 0,
    required this.name,
    required this.sortIndex,
    this.isFinished = false,
    this.importancy = 0,
  }) : identity = UniqueKey().toString();
}
