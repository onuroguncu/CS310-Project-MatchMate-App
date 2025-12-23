import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; // Benzersiz ID üretmek için (pubspec'e eklenmeli)
import '../models/gift_model.dart';
import '../services/firestore_service.dart';
import '../utils/app_colors.dart';

class AddGiftScreen extends StatefulWidget {
  const AddGiftScreen({super.key});

  @override
  State<AddGiftScreen> createState() => _AddGiftScreenState();
}

class _AddGiftScreenState extends State<AddGiftScreen> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  String _selectedTier = 'Standard';
  final FirestoreService _firestoreService = FirestoreService();

  void _saveGift() async {
    if (_titleController.text.isEmpty) return;

    final newGift = GiftModel(
      id: const Uuid().v4(), // Rastgele ID
      title: _titleController.text,
      tier: _selectedTier,
      price: double.tryParse(_priceController.text) ?? 0.0,
      date: DateTime.now().toString().substring(0, 10),
    );

    try {
      await _firestoreService.addGift(newGift);
      if (mounted) Navigator.pop(context); // Başarılıysa geri dön
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hata: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Gift')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Gift Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedTier,
              isExpanded: true,
              items: ['Standard', 'Premium', 'Luxury'].map((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
              onChanged: (val) => setState(() => _selectedTier = val!),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, minimumSize: const Size(double.infinity, 50)),
              onPressed: _saveGift,
              child: const Text('Save to Firebase'),
            ),
          ],
        ),
      ),
    );
  }
}