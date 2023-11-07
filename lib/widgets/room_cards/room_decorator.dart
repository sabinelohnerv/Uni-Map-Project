import 'package:flutter/material.dart';

abstract class ClassroomDecorator extends StatelessWidget {
  final Widget child;
  const ClassroomDecorator({super.key, required this.child});

  @override
  Widget build(BuildContext context);
}