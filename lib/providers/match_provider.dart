import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../services/firestore_service.dart';

class MatchProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  
  List<EventModel> _events = [];
  bool _isLoading = false;

  List<EventModel> get events => _events;
  bool get isLoading => _isLoading;

  MatchProvider() {
    _listenToEvents();
  }

  void _listenToEvents() {
    _isLoading = true;
    _firestoreService.getEvents().listen((eventList) {
      _events = eventList;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> addEvent(EventModel event) async {
    try {
      await _firestoreService.createEvent(event);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateEvent(EventModel event) async {
    try {
      await _firestoreService.updateEvent(event);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteEvent(String id) async {
    try {
      await _firestoreService.deleteEvent(id);
    } catch (e) {
      rethrow;
    }
  }
}
