import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'record_screen.dart';

class DayClipsScreen extends StatelessWidget {
  final String date;
  const DayClipsScreen({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Entries for $date')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.mic),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => RecordScreen(date: date))
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('voice_entries').where('date', isEqualTo: date).snapshots(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (ctx, i) {
              final data = docs[i].data();
              return ExpansionTile(
                title: Text('Audio #${i + 1}'),
                subtitle: Text(data['transcript'] ?? 'No transcript'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(data['summary'] ?? 'No summary'),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}