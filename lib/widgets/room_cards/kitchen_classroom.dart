import 'package:flutter/material.dart';
import 'package:uni_map/widgets/room_cards/room_decorator.dart';

class KitchenClassroomDecorator extends ClassroomDecorator {
  const KitchenClassroomDecorator({super.key, required Widget child}) : super(child: child);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange[50],
      ),
      child: Stack(
        children: [
          child,
          const Positioned(
            right: 10,
            top: 10,
            child: Icon(Icons.soup_kitchen, color: Colors.orange),
          ),
        ],
      ),
    );
  }
}
