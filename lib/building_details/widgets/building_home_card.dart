import 'package:flutter/material.dart';
import 'package:uni_map/screens/rooms_by_building.dart';

class BuildingHomeCard extends StatelessWidget {
  const BuildingHomeCard({
    required this.requestId,
    required this.name,
    required this.description,
    super.key,
  });

  final String requestId;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RoomsByBuilding(id: requestId)),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 117, 13, 54),
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: ListTile(
              title: Text(
                name,
                style: const TextStyle(fontSize: 18),
              ),
              subtitle: Text(
                description,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
