import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _titleController = TextEditingController();
  String selectedType = 'Anniversary';
  DateTime selectedDate = DateTime.now();
  final List<String> eventTypes = ['Anniversary', 'Birthday', 'Special Date', 'Vacation Plan'];

  // Tarih seçici
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text("Add New Special Day"),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Event Title", style: TextStyle(color: Colors.grey)),
            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "e.g., First Vacation",
                hintStyle: TextStyle(color: Colors.white24),
              ),
            ),
            const SizedBox(height: 30),
            const Text("Category", style: TextStyle(color: Colors.grey)),
            DropdownButton<String>(
              value: selectedType,
              dropdownColor: const Color(0xFF1E1E1E),
              isExpanded: true,
              style: const TextStyle(color: Color(0xFFFF7A45), fontSize: 18),
              items: eventTypes.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => selectedType = val!),
            ),
            const SizedBox(height: 30),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Date", style: TextStyle(color: Colors.grey)),
              subtitle: Text("${selectedDate.toLocal()}".split(' ')[0],
                  style: const TextStyle(color: Colors.white, fontSize: 18)),
              trailing: const Icon(Icons.calendar_month, color: Color(0xFFFF7A45)),
              onTap: () => _selectDate(context),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  if (_titleController.text.isNotEmpty) {
                    await _firestoreService.addEvent(_titleController.text, selectedType, selectedDate);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF7A45)),
                child: const Text("Save", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}