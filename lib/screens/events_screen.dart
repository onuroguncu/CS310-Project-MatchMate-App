import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../services/firestore_service.dart';

class EventsScreen extends StatelessWidget {
  final FirestoreService _fs = FirestoreService();

  EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Tema Renkleri
    const Color primaryOrange = Color(0xFFFB923C);
    const Color cardBackground = Color(0xFF1E293B);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Events", style: TextStyle(fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false, // BottomNav olduğu için geri butonunu kaldırır
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryOrange,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => _showAddEventDialog(context),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _fs.getEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: primaryOrange));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_busy_rounded, size: 60, color: Colors.white.withOpacity(0.2)),
                  const SizedBox(height: 10),
                  const Text("No events planned yet", style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          final events = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: events.length,
            itemBuilder: (context, index) {
              var doc = events[index];
              var event = doc.data() as Map<String, dynamic>;
              DateTime date = (event['date'] as Timestamp).toDate();

              // Kalan gün hesabı
              final now = DateTime.now();
              final today = DateTime(now.year, now.month, now.day);
              final eventDay = DateTime(date.year, date.month, date.day);
              int daysLeft = eventDay.difference(today).inDays;

              // Görseldeki gibi kartlara sırayla farklı renkler atar
              List<Color> accentColors = [
                const Color(0xFFFB923C), // Turuncu
                const Color(0xFF818CF8), // Mor/Mavi
                const Color(0xFF34D399), // Yeşil
                const Color(0xFFF472B6), // Pembe
              ];
              Color accentColor = accentColors[index % accentColors.length];

              return Dismissible(
                key: Key(doc.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(20)),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) => _fs.deleteEvent(doc.id),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardBackground,
                    borderRadius: BorderRadius.circular(20),
                    // Görseldeki sol renkli şerit
                    border: Border(left: BorderSide(color: accentColor, width: 6)),
                  ),
                  child: Row(
                    children: [
                      // Sol İkon Kutusu
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: accentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.celebration_rounded, color: accentColor, size: 28),
                      ),
                      const SizedBox(width: 15),
                      // Orta Bilgiler
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event['title'],
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.access_time, size: 14, color: Colors.grey),
                                const SizedBox(width: 5),
                                Text(
                                  DateFormat('MMMM dd, yyyy').format(date),
                                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Sağdaki Kırmızı Gün Rozeti (Badge)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          daysLeft == 0 ? "Today" : "$daysLeft days",
                          style: const TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Yeni Etkinlik Ekleme Diyaloğu
  void _showAddEventDialog(BuildContext context) {
    final titleController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("New Special Day"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Event Title (e.g. Birthday)"),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
                trailing: const Icon(Icons.calendar_month, color: Color(0xFFFB923C)),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2035),
                  );
                  if (picked != null) setDialogState(() => selectedDate = picked);
                },
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty) {
                  await _fs.addEvent(titleController.text, selectedDate);
                  if (context.mounted) Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}