
import 'package:flutter/material.dart';
import 'package:uni_map/screens/rooms_by_building.dart';

class BuildingHomeCard extends StatelessWidget{
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
    return GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RoomsByBuilding(id: requestId)),
            );
          },
          child: Card(
            margin: const EdgeInsets.all(8),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
              side: const BorderSide(
                  color: Color.fromARGB(255, 13, 32, 117), width: 2.0),
            ),
            child: Column(
              children: [
                Image.asset('assets/icon/icon.png'),
                ListTile(
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
                )
              ],
            )
          ),
        );
  }

}