import 'package:flutter/material.dart';
import 'day_clips_screen.dart';

class MonthDaysScreen extends StatelessWidget {
  final int month;
  const MonthDaysScreen({super.key, required this.month});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Month $month - Days')),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (ctx, i) {
          final day = i + 1;
          return ListTile(
            title: Text('Day $day'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DayClipsScreen(date: '2025-${month.toString().padLeft(2, '0')}-$day')),
            ),
          );
        },
      ),
    );
  }
}