import 'package:flutter/material.dart';
import 'package:uni_map/services/search_history_service.dart';
import 'package:uni_map/widgets/search_history_card.dart';

class SearchHistory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchHistoryState();
  }
}

class _SearchHistoryState extends State<SearchHistory> {
  final SearchHistoryService _searchHistoryService = SearchHistoryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Row(
          children: [
            SizedBox(
              width: 57,
            ),
            Image(
              image: AssetImage('assets/images/logo.png'),
              height: 33,
              width: 33,
              color: Colors.white,
            ),
            SizedBox(
              width: 5,
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _searchHistoryService.getSearchHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No search history found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var searchItem = snapshot.data![index];
                return SearchHistoryCard(
                  displayText: searchItem['query'],
                );
              },
            );
          }
        },
      ),
    );
  }
}