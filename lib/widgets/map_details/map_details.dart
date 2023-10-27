import 'package:flutter/material.dart';
import 'package:uni_map/widgets/map_details/building_info.dart';

class MapDetail extends StatelessWidget {
  const MapDetail({
    super.key,
    required this.image,
    required this.topPosition,
    required this.rightPosition,
    required this.imageWidth,
    required this.imageHeight,
  });

  final String image;
  final double topPosition;
  final double rightPosition;
  final double imageWidth;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topPosition,
      right: rightPosition,
      child: GestureDetector(
        onTap: () {
          showDialog(
          context: context,
          builder: (BuildContext context) => const BuildingInfo(),
        );
        },
        child: Image.asset('assets/images/$image.png', width: imageWidth, height: imageHeight,),
      ),
    );
  }
}
