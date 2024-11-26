import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../helper/db_helper.dart';
import '../services/expance_service.dart';
import '../modal/expance_modal.dart';

class ExpenseProvider extends ChangeNotifier {
  List notesList = [];
  var txtTitle = TextEditingController();
  var txtCategory = TextEditingController();
  var txtAmount = TextEditingController();
  var txtSearch = TextEditingController();
  String date = '';
  int id = 0;

  // Firebase Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> initDatabase() async {
    await DatabaseHelper.databaseHelper.initDatabase();
  }

  void clearAll() {
    txtAmount.clear();
    txtCategory.clear();
    txtTitle.clear();
    date = '';
    notifyListeners();
  }

  Future<void> syncCloudToLocal() async {
    final snapshot =
    await ExpenseServices.expenseServices.readDataFromStore().first;
    final cloudExpense = snapshot.docs.map(
          (doc) {
        final data = doc.data();
        return ExpenseModal(
          id: data['id'],
          title: data['title'],
          category: data['category'],
          date: data['date'],
          amount: data['amount'].toString(),
        );
      },
    ).toList();

    for (var expense in cloudExpense) {
      bool exists =
      await DatabaseHelper.databaseHelper.expenseExist(expense.id);

      if (exists) {
        await updateNoteInDatabase(
          id: expense.id,
          title: expense.title,
          date: expense.date,
          amount: double.parse(expense.amount),
          category: expense.category,
        );
      } else {
        await insertExpenseToDatabase(
          id: expense.id,
          title: expense.title,
          date: expense.date,
          amount: double.parse(expense.amount),
          category: expense.category,
        );
      }
    }
  }

  Future<void> addDataInStore({
    required int id,
    required String title,
    required String date,
    required double amount,
    required String category,
  }) async {
    await ExpenseServices.expenseServices.addDataInStore(
      id: id,
      title: title,
      date: date,
      amount: amount,
      category: category,
    );
  }

  List<ExpenseModal> searchListCategory = [];
  List searchList = [];
  String search = '';

  void getSearch(String value) {
    search = value;
    getCategoryExpense();
    notifyListeners();
  }

  Future<List<Map<String, Object?>>> getCategoryExpense() async {
    return searchList =
    await DatabaseHelper.databaseHelper.getExpenseByCategory(search);
  }

  Future<void> insertExpenseToDatabase({
    required int id,
    required String title,
    required String date,
    required double amount,
    required String category,
  }) async {
    await DatabaseHelper.databaseHelper.addExpenseToDatabase(
      id,
      title,
      date,
      amount.toString(),
      category,
    );
    readDataFromDatabase();
    clearAll();
  }

  Future<List<Map<String, Object?>>> readDataFromDatabase() async {
    return notesList = await DatabaseHelper.databaseHelper.readAllExpense();
  }

  Future<void> updateNoteInDatabase({
    required int id,
    required String title,
    required String date,
    required double amount,
    required String category,
  }) async {
    await DatabaseHelper.databaseHelper.updateExpense(
      id,
      title,
      date,
      amount.toString(),
      category,
    );
    readDataFromDatabase();
    clearAll();
  }

  Future<void> deleteNoteInDatabase({required int id}) async {
    await DatabaseHelper.databaseHelper.deleteExpense(id);
    readDataFromDatabase();
    notifyListeners();
  }

  // New method to backup data to Firebase
  Future<void> backupDataToFirebase() async {
    try {
      // Fetch all notes from local storage
      List<ExpenseModal> notes = (await readDataFromDatabase()).cast<ExpenseModal>();

      // Iterate through the notes and push them to Firestore
      for (var note in notes) {
        await _firestore.collection('expenses').doc('${note.id}').set({
          'id': note.id,
          'title': note.title,
          'amount': double.parse(note.amount),
          'category': note.category,
          'date': note.date,
        });
      }

      // Optionally, you can show a success message
      print('Data backed up to Firebase successfully.');
    } catch (e) {
      // Handle any errors that occur during the backup process
      print('Error backing up data to Firebase: $e');
      throw Exception('Failed to backup data to Firebase');
    }
  }

  // Constructor for initialization
  NotesProvider() {
    initDatabase();
  }
}
