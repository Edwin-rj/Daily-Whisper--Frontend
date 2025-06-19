import 'package:flutter/material.dart';
import 'package:voiceapp/screens/month_days_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final months = List.generate(12, (i) => DateTime(2025, i + 1).month);

    return Scaffold(
      appBar: AppBar(title: const Text('Select Month')),
      body: ListView.builder(
        itemCount: months.length,
        itemBuilder: (ctx, i) {
          return ListTile(
            title: Text('Month ${months[i]}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MonthDaysScreen(month: months[i]))
              );
            },
          );
        },
      ),
    );
  }
}