import 'package:flutter/material.dart';
import 'package:uni_map/screens/rooms_by_building.dart';

class BuildingHomeCard extends StatelessWidget {
  const BuildingHomeCard({
    required this.requestId,
    required this.name,
    super.key,
  });

  final String requestId;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomsByBuilding(id: requestId),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
          side: const BorderSide(
            color: Color.fromARGB(255, 13, 32, 117),
            width: 2.0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14.0),
          child: Stack(
            children: [
              Image.asset(
                'assets/icon/icon.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.black.withOpacity(0.6),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
