import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../services/notification_service.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  final FirestoreService _fs = FirestoreService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        title: const Text("Plan a Special Day", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            // BAŞLIK GİRİŞİ
            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                labelText: "What is the occasion?",
                labelStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.edit, color: Colors.redAccent),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.white12)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.redAccent)),
                filled: true,
                fillColor: const Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 20),

            // TARİH SEÇİCİ
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                  builder: (context, child) => Theme(
                    data: ThemeData.dark().copyWith(colorScheme: const ColorScheme.dark(primary: Colors.redAccent)),
                    child: child!,
                  ),
                );
                if (picked != null) setState(() => _selectedDate = picked);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.redAccent),
                    const SizedBox(width: 15),
                    Text(
                      "Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // KAYDET BUTONU
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 5,
                ),
                onPressed: _isLoading ? null : _saveEvent,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Set Reminder", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Kaydetme Fonksiyonu
  Future<void> _saveEvent() async {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter a title!")));
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. Firebase Firestore'a Kaydet
      await _fs.addEvent(_titleController.text, _selectedDate);

      // 2. Bildirimi Programla (1 gün önce ve o gün sabahı)
      await NotificationService().scheduleNotification(
        _selectedDate.millisecondsSinceEpoch ~/ 100000, // Benzersiz ID oluştur
        _titleController.text,
        _selectedDate,
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(backgroundColor: Colors.green, content: Text("Event saved and notifications scheduled! ❤️")),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }
}