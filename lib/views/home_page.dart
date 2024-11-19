import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modal/inventory_modal.dart';
import '../services/inventory_service.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final InventoryService _inventoryService = InventoryService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  void _addItem() async {
    final name = _nameController.text;
    final quantity = int.tryParse(_quantityController.text);
    final category = _categoryController.text;

    if (name.isEmpty || category.isEmpty || quantity == null || quantity <= 0) {
      Get.snackbar("Validation Error", "Please fill all fields correctly.");
      return;
    }

    Item newItem = Item(
      id: '',
      name: name,
      quantity: quantity,
      category: category,
    );

    await _inventoryService.addItem(newItem);
    _nameController.clear();
    _quantityController.clear();
    _categoryController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventory Management"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Item Name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: "Quantity"),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: "Category"),
            ),
          ),
          ElevatedButton(
            onPressed: _addItem,
            child: const Text("Add Item"),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<List<Item>>(
              stream: _inventoryService.getItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No items found."));
                } else {
                  final items = snapshot.data!;
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text("Category: ${item.category} - Quantity: ${item.quantity}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Edit button
                            IconButton(
                              onPressed: () async {
                                _nameController.text = item.name;
                                _quantityController.text = item.quantity.toString();
                                _categoryController.text = item.category;

                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Update Item"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: _nameController,
                                          decoration: const InputDecoration(labelText: "Item Name"),
                                        ),
                                        TextField(
                                          controller: _quantityController,
                                          decoration: const InputDecoration(labelText: "Quantity"),
                                          keyboardType: TextInputType.number,
                                        ),
                                        TextField(
                                          controller: _categoryController,
                                          decoration: const InputDecoration(labelText: "Category"),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          final updatedItem = Item(
                                            id: item.id,
                                            name: _nameController.text,
                                            quantity: int.parse(_quantityController.text),
                                            category: _categoryController.text,
                                          );


                                          await _inventoryService.updateItem(updatedItem);

                                          _nameController.clear();
                                          _quantityController.clear();
                                          _categoryController.clear();

                                          Navigator.pop(context);
                                        },
                                        child: const Text("Update"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            // Delete button
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                await _inventoryService.deleteItem(item.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
