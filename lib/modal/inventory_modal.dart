import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String id;
  String name;
  int quantity;
  String category;

  Item({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  factory Item.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Item(
      id: doc.id,
      name: data['name'] ?? '',
      quantity: data['quantity'] ?? 0,
      category: data['category'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'category': category,
    };
  }
}
