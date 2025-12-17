import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../widgets/main_bottom_nav.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../routes/app_routes.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late List<EventModel> _events;

  @override
  void initState() {
    super.initState();
    _events = _dummyEvents();
  }

  List<EventModel> _dummyEvents() {
    return [
      EventModel(
        title: 'Anniversary',
        subtitle: 'Book a nice restaurant',
        date: 'November 10, 2025 · 7:00 PM',
        daysLeft: '5 days left',
      ),
      EventModel(
        title: 'Her Birthday',
        subtitle: 'Plan surprise party',
        date: 'December 3, 2025 · 8:30 PM',
        daysLeft: '28 days left',
      ),
      EventModel(
        title: 'First Match Together',
        subtitle: 'Buy match tickets',
        date: 'January 15, 2026 · 9:45 PM',
        daysLeft: '70 days left',
      ),
    ];
  }

  void _removeEvent(int index) {
    setState(() {
      _events.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('Upcoming Events'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.createEvent);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: const MainBottomNav(currentIndex: 1),
      body: _events.isEmpty
          ? const Center(
              child: Text(
                'No events yet.\nTap + to create one!',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final e = _events[index];

                return Dismissible(
                  key: ValueKey('${e.title}-${e.date}'),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => _removeEvent(index),
                  background: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 24),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Card(
                      color: AppColors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            // NETWORK IMAGE ✅
                            'https://picsum.photos/seed/${index + 1}/80/80',
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          e.title,
                          style: AppTextStyles.heading2,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            e.subtitle,
                            style: AppTextStyles.body,
                          ),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              e.date,
                              style: AppTextStyles.body.copyWith(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              e.daysLeft,
                              style: const TextStyle(
                                color: AppColors.accentYellow,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}