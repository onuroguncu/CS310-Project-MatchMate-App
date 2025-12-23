import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // --- EVENTS (ETKİNLİKLER) BÖLÜMÜ ---

  // Yeni etkinlik ekleme
  Future<void> addEvent(String title, String type, DateTime date) async {
    try {
      String? uid = _auth.currentUser?.uid;
      if (uid == null) return;

      await _db.collection('events').add({
        'title': title,
        'type': type,
        'date': Timestamp.fromDate(date),
        'createdBy': uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error adding event: $e");
    }
  }

  // Etkinlikleri çekme (Ekran görüntüsündeki hatayı çözmek için orderBy kaldırıldı)
  Stream<List<Map<String, dynamic>>> getEvents() {
    String uid = _auth.currentUser?.uid ?? '';
    return _db
        .collection('events')
        .where('createdBy', isEqualTo: uid)
        .snapshots()
        .map((snap) => snap.docs
        .map((doc) => {...doc.data(), 'id': doc.id})
        .toList());
  }

  // --- STATS (İSTATİSTİKLER) BÖLÜMÜ ---

  // Stats verilerini Firebase'e kaydeder (PerformanceScreen için gerekli)
  Future<void> updatePartnerStats(Map<String, dynamic> stats) async {
    try {
      String? uid = _auth.currentUser?.uid;
      if (uid == null) return;

      await _db.collection('users').doc(uid).set({
        'stats': stats,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error updating stats: $e");
    }
  }

  // Stats verilerini Firebase'den çeker (PerformanceScreen için gerekli)
  Future<Map<String, dynamic>?> getPartnerStats() async {
    try {
      String? uid = _auth.currentUser?.uid;
      if (uid == null) return null;

      DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        return data['stats'] as Map<String, dynamic>?;
      }
    } catch (e) {
      print("Error getting stats: $e");
    }
    return null;
  }
}