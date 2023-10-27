import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uni_map/widgets/map_details/building_card.dart';
import 'package:uni_map/widgets/map_details/map_details.dart';
import 'package:uni_map/widgets/search_bar.dart';

class MapCards extends StatelessWidget {
  const MapCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MapDetail(
          image: 'football_field',
          topPosition: 418,
          rightPosition: 160,
          imageWidth: 75,
          imageHeight: 75,
        ),
        const MapDetail(
          image: 'hexagon_cowork',
          topPosition: 160,
          rightPosition: 86,
          imageWidth: 80,
          imageHeight: 80,
        ),
        Positioned(
          top: 228,
          left: 225,
          child: BuildingCard(
            pHorizontal: 4,
            pVertical: 15,
            color: Colors.indigo.shade200,
            moduleText: 'Módulo 4',
          ),
        ),
        Positioned(
          top: 180,
          left: 90,
          child: BuildingCard(
            pHorizontal: 16,
            pVertical: 20,
            color: Colors.orange.shade300,
            moduleText: 'Módulo 2',
          ),
        ),
        Positioned(
          top: 177,
          left: 167,
          child: Card(
            color: Colors.orange.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80),
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
            ),
          ),
        ),
        Positioned(
          top: 105,
          left: 125,
          child: BuildingCard(
            pHorizontal: 24,
            pVertical: 8,
            color: Colors.red.shade300,
            moduleText: '',
          ),
        ),
        Positioned(
          top: 155,
          left: 120,
          child: BuildingCard(
            pHorizontal: 30,
            pVertical: 3,
            color: Colors.red.shade300,
            moduleText: '',
          ),
        ),
        Positioned(
          top: 105,
          left: 90,
          child: BuildingCard(
            pHorizontal: 2,
            pVertical: 20,
            color: Colors.red.shade300,
            moduleText: 'Módulo\n8',
          ),
        ),
        Positioned(
          top: 120,
          left: 222,
          child: BuildingCard(
            pHorizontal: 4,
            pVertical: 11,
            color: Colors.orange.shade100,
            moduleText: '',
            icon: Icons.fastfood,
          ),
        ),
        Positioned(
          top: 296,
          left: 116,
          child: BuildingCard(
            pHorizontal: 20,
            pVertical: 14,
            color: Colors.green.shade200,
            moduleText: '',
          ),
        ),
        Positioned(
          top: 325,
          left: 124,
          child: BuildingCard(
            pHorizontal: 26,
            pVertical: 14,
            color: Colors.green.shade200,
            moduleText: '',
          ),
        ),
        Positioned(
          top: 290,
          left: 111,
          child: BuildingCard(
            pHorizontal: 4,
            pVertical: 14,
            color: Colors.green.shade200,
            moduleText: 'Módulo 3A',
          ),
        ),
        Positioned(
          top: 308,
          left: 200,
          child: BuildingCard(
            pHorizontal: 18,
            pVertical: 20,
            color: Colors.green.shade200,
            moduleText: '',
          ),
        ),
        Positioned(
          top: 292,
          left: 200,
          child: BuildingCard(
            pHorizontal: 8,
            pVertical: 8,
            color: Colors.green.shade200,
            moduleText: 'Módulo \n3B',
          ),
        ),
        Positioned(
          top: 362,
          left: 181,
          child: BuildingCard(
            pHorizontal: 2,
            pVertical: 2,
            color: Colors.green.shade200,
            moduleText: 'Módulo \n3C',
          ),
        ),
        Positioned(
          top: 592,
          left: 83,
          child: BuildingCard(
            pHorizontal: 2,
            pVertical: 14,
            color: Colors.blue.shade200,
            moduleText: 'Módulo 7',
          ),
        ),
        Positioned(
          top: 64,
          left: 188,
          child: Transform.rotate(
            angle: pi/20,
            child: BuildingCard(
              pHorizontal: 14,
              pVertical: 2,
              color: Colors.yellow.shade500,
              moduleText: '',
            ),
          ),
        ),
        Positioned(
          top: 57,
          left: 130,
          child: Transform.rotate(
            angle: pi/20,
            child: BuildingCard(
              pHorizontal: 4,
              pVertical: 2,
              color: Colors.yellow.shade500,
              moduleText: 'Módulo \n1A',
            ),
          ),
        ),
        Positioned(
          top: 69,
          left: 214,
          child: Transform.rotate(
            angle: pi/20,
            child: BuildingCard(
              pHorizontal: 10,
              pVertical: 6,
              color: Colors.yellow.shade500,
              moduleText: '1B',
            ),
          ),
        ),
        Positioned(
          top: 61,
          left: 100,
          child: Transform.rotate(
            angle: pi/20,
            child: BuildingCard(
              pHorizontal: 3,
              pVertical: 1,
              color: Colors.orange.shade500,
              moduleText: '',
              icon: Icons.monetization_on,
            ),
          ),
        ),
        Positioned(
          top: 250,
          left: 60,
          child: BuildingCard(
            pHorizontal: 2,
            pVertical: 2,
            color: Colors.blue.shade100,
            moduleText: '',
            icon: Icons.local_parking,
          ),
        ),
        const Positioned(
          top: 8.0,
          left: 15.0,
          right: 15.0,
          child: LocationSearchBar(),
        ),
      ],
    );
  }
}
