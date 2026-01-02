import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';
import '../routes/app_routes.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final FirestoreService _fs = FirestoreService();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryOrange = Color(0xFFFB923C);

    return Scaffold(
      appBar: AppBar(title: const Text("Calendar")),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryOrange,
        onPressed: () => Navigator.pushNamed(context, AppRoutes.events),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _fs.getEvents(),
        builder: (context, snapshot) {
          Map<DateTime, List> eventDays = {};
          if (snapshot.hasData) {
            for (var doc in snapshot.data!.docs) {
              DateTime date = (doc['date'] as Timestamp).toDate();
              DateTime dayOnly = DateTime(date.year, date.month, date.day);
              if (eventDays[dayOnly] == null) eventDays[dayOnly] = [];
              eventDays[dayOnly]!.add(doc['title']);
            }
          }

          return Column(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(20)),
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2035, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  eventLoader: (day) => eventDays[DateTime(day.year, day.month, day.day)] ?? [],
                  onDaySelected: (selectedDay, focusedDay) => setState(() { _selectedDay = selectedDay; _focusedDay = focusedDay; }),
                  calendarStyle: const CalendarStyle(
                    markerDecoration: BoxDecoration(color: primaryOrange, shape: BoxShape.circle),
                    selectedDecoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFEA580C), primaryOrange]), shape: BoxShape.circle),
                    todayDecoration: BoxDecoration(color: Colors.white12, shape: BoxShape.circle),
                    weekendTextStyle: TextStyle(color: primaryOrange),
                  ),
                  headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true, leftChevronIcon: Icon(Icons.chevron_left, color: primaryOrange), rightChevronIcon: Icon(Icons.chevron_right, color: primaryOrange)),
                ),
              ),
              Expanded(child: _buildEventList(snapshot)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEventList(AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
    final dailyEvents = snapshot.data!.docs.where((doc) => isSameDay((doc['date'] as Timestamp).toDate(), _selectedDay)).toList();
    if (dailyEvents.isEmpty) return const Center(child: Text("No events for this day", style: TextStyle(color: Colors.grey)));
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: dailyEvents.length,
      itemBuilder: (context, index) => Card(
        color: Colors.white.withOpacity(0.05),
        child: ListTile(leading: const Icon(Icons.star, color: Color(0xFFFB923C)), title: Text(dailyEvents[index]['title'])),
      ),
    );
  }
  bool isSameDay(DateTime? a, DateTime? b) => a?.year == b?.year && a?.month == b?.month && a?.day == b?.day;
}