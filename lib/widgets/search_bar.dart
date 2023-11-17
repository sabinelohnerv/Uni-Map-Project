import 'package:flutter/material.dart';
import 'package:uni_map/screens/search_results.dart';
import 'package:uni_map/services/search_history_service.dart';

class LocationSearchBar extends StatefulWidget {
  const LocationSearchBar({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LocationSearchBarState();
  }
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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
        controller: searchController,
        decoration: InputDecoration(
          hintText: '¿Qué estás buscando?',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 15.0, top: 15.0),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              String query = searchController.text.trim();
              if(query.length > 0){
                SearchHistoryService().saveSearchQuery(query);
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchResults(query: query.toUpperCase())),
              );
            },
            iconSize: 30.0,
          ),
        ),
      ),
    );
  }
}