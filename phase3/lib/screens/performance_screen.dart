import 'package:flutter/material.dart';
import '../widgets/main_bottom_nav.dart';
import '../services/firestore_service.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  final FirestoreService _fs = FirestoreService();

  // Kontrolcüler
  final _myCtrl = TextEditingController();
  final _partnerCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();
  final _colorCtrl = TextEditingController();
  final _giftCtrl = TextEditingController();

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadExistingStats(); // Sayfa açıldığında verileri yükle
  }

  // Firebase'den verileri getirip kutucuklara doldurur
  void _loadExistingStats() async {
    final data = await _fs.getPartnerStats();
    if (data != null) {
      setState(() {
        _myCtrl.text = data['myName'] ?? '';
        _partnerCtrl.text = data['partnerName'] ?? '';
        _dateCtrl.text = data['birthDate'] ?? '';
        _colorCtrl.text = data['favColor'] ?? '';
        _giftCtrl.text = data['favGift'] ?? '';
      });
    }
  }

  // Firebase'e verileri gönderir
  void _saveStats() async {
    setState(() => _isSaving = true);

    Map<String, dynamic> statsData = {
      'myName': _myCtrl.text,
      'partnerName': _partnerCtrl.text,
      'birthDate': _dateCtrl.text,
      'favColor': _colorCtrl.text,
      'favGift': _giftCtrl.text,
    };

    await _fs.updatePartnerStats(statsData);

    if (mounted) {
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Stats saved to cloud successfully!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(title: const Text("Partner Stats"), backgroundColor: Colors.transparent),
      bottomNavigationBar: MainBottomNav(currentIndex: 2),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildField("My Name", _myCtrl, Icons.person),
            _buildField("Partner Name", _partnerCtrl, Icons.favorite),
            _buildField("Partner's Birth Date", _dateCtrl, Icons.cake),
            _buildField("Favorite Color", _colorCtrl, Icons.palette),
            _buildField("Preferred Gift", _giftCtrl, Icons.card_giftcard),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7A45),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: _isSaving ? null : _saveStats,
                child: _isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("SAVE CHANGES", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController ctrl, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: ctrl,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFFFF7A45)),
          prefixIcon: Icon(icon, color: Colors.grey),
          filled: true,
          fillColor: const Color(0xFF1E1E1E),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}