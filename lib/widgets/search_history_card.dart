import 'package:flutter/material.dart';
import 'package:uni_map/screens/search_results.dart';

class SearchHistoryCard extends StatelessWidget {
  const SearchHistoryCard({
    super.key,
    required this.displayText,
  });

  final String displayText;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 24),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidth * 0.5,
            child: Text(
              style: TextStyle(fontSize: 16),
              displayText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SearchResults(query: displayText.toUpperCase())),
              );
            },
            iconSize: 25.0,
          ),
        ],
      ),
    );
  }
}