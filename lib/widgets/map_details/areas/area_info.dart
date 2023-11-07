import 'package:flutter/material.dart';
import 'package:uni_map/services/api/api_service_areas.dart'; 

class AreaInfo extends StatelessWidget {
  final String buildingId;

  const AreaInfo({
    super.key,
    required this.buildingId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: ApiServiceAreas().fetchAreaDetails(buildingId),
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
            actions: <Widget>[
              TextButton(
                child: const Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
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
