import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createEvent(EventModel event) async {
    await _db.collection('events').doc(event.id).set(event.toMap());
  }

  Stream<List<EventModel>> getEvents() {
    return _db
        .collection('events')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => EventModel.fromMap(doc.data()))
            .toList());
  }

  Future<void> updateEvent(EventModel event) async {
    await _db.collection('events').doc(event.id).update(event.toMap());
  }

  Future<void> deleteEvent(String id) async {
    await _db.collection('events').doc(id).delete();
  }
}
