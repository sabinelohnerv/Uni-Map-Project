import 'package:flutter/material.dart';
import 'package:uni_map/services/api/api_service_rooms.dart';
import 'package:uni_map/widgets/room_cards/auditorium_classroom.dart';
import 'package:uni_map/widgets/room_cards/computer_classroom.dart';
import 'package:uni_map/widgets/room_cards/design_classroom.dart';
import 'package:uni_map/widgets/room_cards/kitchen_classroom.dart';
import 'package:uni_map/widgets/room_cards/lab_classroom.dart';
import 'package:uni_map/widgets/room_cards/room_card.dart';
import 'package:uni_map/widgets/room_cards/smart_classroom.dart';

class RoomsByBuilding extends StatefulWidget {
  const RoomsByBuilding({super.key, required this.id});

  final String id;

  @override
  State<StatefulWidget> createState() {
    return _RoomByBuildingState();
  }
}

class _RoomByBuildingState extends State<RoomsByBuilding> {
  late Future<List<dynamic>> roomsFuture;
  late Future<dynamic> buildingDetailsFuture;
  late Future<List<dynamic>> areasFuture;

  @override
  void initState() {
    super.initState();
    final apiService = ApiServiceRooms();
    roomsFuture = apiService.fetchRoomsByBuilding(widget.id);
    buildingDetailsFuture = apiService.fetchBuildingDetails(widget.id);
    areasFuture = apiService.fetchAreasByBuilding(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Row(
          children: [
            SizedBox(
              width: 26,
            ),
            Image(
              image: AssetImage('assets/images/univalle_wordless.png'),
              height: 55,
              width: 55,
              color: Colors.white,
            ),
            SizedBox(
              width: 1,
            ),
            Text(
              'UniMap',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 16,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FutureBuilder<dynamic>(
              future: buildingDetailsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  var building = snapshot.data;
                  return Container(
                    padding: const EdgeInsets.all(8),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: ListTile(
                      title: Text(
                        building['name'] ?? 'No name available',
                        style: const TextStyle(fontSize: 17),
                      ),
                      subtitle: Text(
                        building['description'] ?? 'No description available',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            buildExpandableList('Aulas y Laboratorios', roomsFuture),
            buildExpandableList('Áreas Comunes y Otros', areasFuture),
          ],
        ),
      ),
    );
  }
}

Widget buildExpandableList(String title, Future<List<dynamic>> futureList) {
  return FutureBuilder<List<dynamic>>(
    future: futureList,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError ||
          !snapshot.hasData ||
          snapshot.data!.isEmpty) {
        return const SizedBox.shrink();
      } else {
        var items = snapshot.data!;
        return ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 24),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          children: items.map<Widget>((item) {
            String displayText =
                "${item['id'] ?? 'No ID'} - ${item['name'] ?? 'No name'}";
            String finalText =
                title == 'Aulas y Laboratorios' ? displayText : item['name'];
            String itemName = item['name']
                .toString()
                .toUpperCase();
            Widget roomCard =
                RoomCard(displayText: finalText, level: item['level']);
            if (itemName.contains('SMART')) {
              roomCard = SmartClassroomDecorator(child: roomCard);
            } else if (itemName
                .contains('LABORATORIO') && !itemName.contains('COCINA') && !itemName.contains('PANADERIA') && !itemName.contains('PASTELERIA') && !itemName.contains('FABLAB')) {
              roomCard = LabClassroomDecorator(child: roomCard);
            } else if (itemName.contains('COMPUTO')) {
              roomCard = ComputerClassroomDecorator(child: roomCard);
            } else if (itemName.contains('COCINA') || itemName.contains('PANADERIA') || itemName.contains('PASTELERIA')) {
              roomCard = KitchenClassroomDecorator(child: roomCard);
            } else if (itemName.contains('AUDITORIO')) {
              roomCard = AuditoriumClassroomDecorator(child: roomCard);
            } else if (itemName.contains('FABLAB')) {
              roomCard = DesignClassroomDecorator(child: roomCard);
            }
            return roomCard;
          }).toList(),
        );
      }
    },
  );
}
