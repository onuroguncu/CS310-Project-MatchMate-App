import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../routes/app_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthService _auth = AuthService();
  final FirestoreService _fs = FirestoreService();
  final _nameController = TextEditingController();
  final _partnerController = TextEditingController();
  final _flowerController = TextEditingController();
  final _foodController = TextEditingController();
  final _hobbyController = TextEditingController();
  final _noteController = TextEditingController();
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    const Color primaryOrange = Color(0xFFFB923C);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save_rounded : Icons.edit_rounded, color: _isEditing ? Colors.greenAccent : Colors.white),
            onPressed: () async {
              if (_isEditing) {
                await _fs.updateUserProfile(_nameController.text, _partnerController.text, {
                  'favoriteFlower': _flowerController.text,
                  'favoriteFood': _foodController.text,
                  'hobby': _hobbyController.text,
                  'note': _noteController.text,
                });
              }
              setState(() => _isEditing = !_isEditing);
            },
          )
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _fs.getUserProfile(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          var userData = snapshot.data!.data() as Map<String, dynamic>;
          var extras = userData['partnerExtras'] ?? {};
          if (!_isEditing) {
            _nameController.text = userData['userName'] ?? "";
            _partnerController.text = userData['partnerName'] ?? "";
            _flowerController.text = extras['favoriteFlower'] ?? "";
            _foodController.text = extras['favoriteFood'] ?? "";
            _hobbyController.text = extras['hobby'] ?? "";
            _noteController.text = extras['note'] ?? "";
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle("General Info", primaryOrange),
                _buildField("My Name", _nameController, Icons.person_outline, primaryOrange),
                _buildField("Partner's Name", _partnerController, Icons.favorite_border, primaryOrange),
                const SizedBox(height: 20),
                _buildTitle("Partner's Favorites", primaryOrange),
                _buildField("Favorite Flower", _flowerController, Icons.local_florist, primaryOrange),
                _buildField("Favorite Food", _foodController, Icons.restaurant, primaryOrange),
                _buildField("Hobbies", _hobbyController, Icons.auto_awesome, primaryOrange),
                _buildField("Special Notes", _noteController, Icons.edit_note, primaryOrange, maxLines: 3),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.redAccent, side: const BorderSide(color: Colors.redAccent)),
                    onPressed: () async { await _auth.signOut(); Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (r) => false); },
                    child: const Text("Log Out"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitle(String t, Color c) => Padding(padding: const EdgeInsets.only(bottom: 10), child: Text(t, style: TextStyle(color: c, fontSize: 18, fontWeight: FontWeight.bold)));
  Widget _buildField(String l, TextEditingController c, IconData i, Color orange, {int maxLines = 1}) => Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: TextField(
      controller: c, enabled: _isEditing, maxLines: maxLines,
      decoration: InputDecoration(labelText: l, prefixIcon: Icon(i, color: _isEditing ? orange : Colors.grey), filled: true, fillColor: Colors.white.withOpacity(0.05), border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none)),
    ),
  );
}