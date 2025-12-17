import 'package:flutter/material.dart';
import '../utils/app_text_styles.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _date = '';
  String _time = '';
  String _notes = '';

  void _save() {
    if (!_formKey.currentState!.validate()) {
      // AlertDialog gereksinimi
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Form Error'),
          content: const Text('Please fix the highlighted errors.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    _formKey.currentState!.save();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Create Event')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width > 600 ? width * 0.2 : 24,
          vertical: 24,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Event Details', style: AppTextStyles.heading1),
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Event Title',
                  hintText: 'e.g. Anniversary Dinner',
                  filled: true,
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Title is required' : null,
                onSaved: (v) => _title = v ?? '',
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Date',
                  hintText: 'dd.mm.yyyy',
                  filled: true,
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Date is required' : null,
                onSaved: (v) => _date = v ?? '',
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Time',
                  hintText: 'hh:mm',
                  filled: true,
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Time is required' : null,
                onSaved: (v) => _time = v ?? '',
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  hintText: 'Add notes or reminders...',
                  filled: true,
                ),
                minLines: 3,
                maxLines: 5,
                onSaved: (v) => _notes = v ?? '',
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _save,
                      child: const Text('Save Event'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
