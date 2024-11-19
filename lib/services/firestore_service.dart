import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> syncItems(List<Map<String, dynamic>> items) async {
    for (var item in items) {
      await _db.collection('inventory').add(item);
    }
  }

  Future<List<Map<String, dynamic>>> getInventory() async {
    var snapshot = await _db.collection('inventory').get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}
