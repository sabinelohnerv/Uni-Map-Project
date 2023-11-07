import 'package:flutter/material.dart';
import 'package:uni_map/screens/rooms_by_building.dart';
import 'package:uni_map/services/api/api_service.dart';

class BuildingInfo extends StatelessWidget {
  final String buildingId;

  const BuildingInfo({
    super.key,
    required this.buildingId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: ApiService().fetchBuildingDetails(buildingId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('${snapshot.error}'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return AlertDialog(
            title: Text(data['name'] ?? 'No Name'),
            content: Text(data['description'] ?? 'No Description'),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text('Ver más'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RoomsByBuilding(id: buildingId)),
                      );
                    },
                  ),
                  TextButton(
                    child: const Text('Cerrar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        } else {
          return const AlertDialog(
            content: Text('No data available'),
          );
        }
      },
    );
  }
}
