import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Task {
  @Id()
  int id = 0;

  String identity;
  String name;
  int importancy = 0;
  bool isFinished = false;

  Task({required this.name}) : identity = UniqueKey().toString();
}
