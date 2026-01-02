import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';

class GiftIdeasScreen extends StatelessWidget {
  final FirestoreService _fs = FirestoreService();

  GiftIdeasScreen({super.key});

  void _showAddGiftDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("New Gift Idea", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "What's the gift?",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: descController,
              maxLines: 2,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Notes or link...",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF43F5E)),
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                _fs.addGift(titleController.text, descController.text);
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wish List", style: TextStyle(fontWeight: FontWeight.bold))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF43F5E),
        onPressed: () => _showAddGiftDialog(context),
        child: const Icon(Icons.add_shopping_cart, color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _fs.getGifts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Wish list is empty.", style: TextStyle(color: Colors.grey)));
          }

          final gifts = snapshot.data!.docs;
          return GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 0.85
            ),
            itemCount: gifts.length,
            itemBuilder: (context, index) {
              var gift = gifts[index];
              var data = gift.data() as Map<String, dynamic>;

              return Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.favorite, color: Color(0xFFF43F5E), size: 18),
                        GestureDetector(
                          onTap: () => _fs.deleteGift(gift.id),
                          child: const Icon(Icons.close, color: Colors.grey, size: 18),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(data['title'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(data['description'], style: const TextStyle(color: Colors.grey, fontSize: 11), maxLines: 2),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}