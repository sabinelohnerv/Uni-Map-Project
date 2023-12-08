import 'package:flutter/material.dart';
import 'package:uni_map/widgets/map_details/areas/area_info.dart';
import 'package:uni_map/widgets/map_details/buildings/building_info.dart';

class SearchResult extends StatelessWidget {
  SearchResult({
    super.key,
    required this.title,
    required this.subtitle,
    required this.Id,
    required this.isBuilding,
  });

  final String title;
  final String subtitle;
  final String Id;
  final bool isBuilding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => isBuilding
              ? BuildingInfo(buildingId: Id)
              : AreaInfo(buildingId: Id),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5, // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Positioned(
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                      ),
                        color: Color(0xFF964164),
                      ),
                      height: 60,
                      width: 8,
                    )
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        style: TextStyle(fontWeight: FontWeight.bold),
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        subtitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
