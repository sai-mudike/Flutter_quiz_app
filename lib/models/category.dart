import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    this.icon = Icons.quiz_rounded,
    this.color = const Color.fromRGBO(251, 192, 45, 1),
  });
  final String id;
  final String title;
  final IconData icon;
  final Color color;
}
