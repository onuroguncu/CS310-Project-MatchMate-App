import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser?.uid ?? "";

  // Profil İşlemleri - Yeni alanlar eklendi
  Future<void> saveUserProfile(String userName, String partnerName, String anniversary) async {
    await _db.collection('users').doc(_uid).set({
      'userName': userName,
      'partnerName': partnerName,
      'anniversary': anniversary,
      'partnerExtras': {
        'favoriteFlower': '',
        'favoriteFood': '',
        'hobby': '',
        'note': '',
      },
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<DocumentSnapshot> getUserProfile() {
    return _db.collection('users').doc(_uid).snapshots();
  }

  // Tüm bilgileri tek seferde güncelleyen metod
  Future<void> updateUserProfile(String userName, String partnerName, Map<String, dynamic> extras) async {
    await _db.collection('users').doc(_uid).update({
      'userName': userName,
      'partnerName': partnerName,
      'partnerExtras': extras,
    });
  }

  // Etkinlik İşlemleri
  Future<void> addEvent(String title, DateTime date) async {
    await _db.collection('users').doc(_uid).collection('events').add({
      'title': title,
      'date': Timestamp.fromDate(date),
    });
  }

  Stream<QuerySnapshot> getEvents() {
    return _db.collection('users').doc(_uid).collection('events').orderBy('date').snapshots();
  }

  Future<void> deleteEvent(String docId) async {
    await _db.collection('users').doc(_uid).collection('events').doc(docId).delete();
  }

  // Hediye İşlemleri
  Future<void> addGift(String title, String description) async {
    await _db.collection('users').doc(_uid).collection('gifts').add({
      'title': title,
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getGifts() {
    return _db.collection('users').doc(_uid).collection('gifts').orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> deleteGift(String docId) async {
    await _db.collection('users').doc(_uid).collection('gifts').doc(docId).delete();
  }
}