import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchHistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveSearchQuery(String query) async {
    String userId = _auth.currentUser?.uid ?? '';
    if (userId.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('search_history')
          .add({
        'query': query,
        'date': Timestamp.now(),
      }).catchError((error){
        print('Error saving search query: $error');
      });
    }
  }

  Future<List<Map<String, dynamic>>> getSearchHistory() async {
    String userId = _auth.currentUser?.uid ?? '';
    List<Map<String, dynamic>> searchHistory = [];

    if (userId.isNotEmpty) {
      try {
        QuerySnapshot querySnapshot = await _firestore
            .collection('users')
            .doc(userId)
            .collection('search_history')
            .orderBy('date',
                descending: true) 
            .get();

        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> searchEntry = doc.data() as Map<String, dynamic>;
          searchHistory.add(searchEntry);
        }
      } catch (error) {
        print('Error retrieving search history: $error');
      }
    }

    return searchHistory;
  }
}