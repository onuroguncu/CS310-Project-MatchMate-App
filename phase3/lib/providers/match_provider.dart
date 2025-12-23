import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../services/firestore_service.dart';

class MatchProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<EventModel> _events = [];
  bool _isLoading = false;

  List<EventModel> get events => _events;
  bool get isLoading => _isLoading;

  // EventsScreen tarafından beklenen metod
  void startListening(String userId) {
    _isLoading = true;
    _firestoreService.getEvents().listen((eventList) {
      _events = eventList;
      _isLoading = false;
      notifyListeners();
    });
  }

  // EventsScreen'deki delete işlemi için takma isim (alias)
  Future<void> removeEvent(String id) async {
    await _firestoreService.deleteEvent(id);
  }

  Future<void> addEvent(EventModel event) async {
    await _firestoreService.createEvent(event);
  }
}