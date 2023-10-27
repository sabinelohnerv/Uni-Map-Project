import 'package:flutter/material.dart';
import 'package:uni_map/widgets/location_search.dart';

class LocationSearchBar extends StatefulWidget {
  const LocationSearchBar({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LocationSearchBarState();
  }
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white.withOpacity(0.8),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: '¿Qué estás buscando?',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 15.0, top: 15.0),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final String? selected = await showSearch(
                context: context,
                delegate: LocationSearch(),
              );
              if (selected != null && selected.isNotEmpty) {
                // TODO
                print(selected);
              }
            },
            iconSize: 30.0,
          ),
        ),
      ),
    );
  }
}
