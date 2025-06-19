import 'package:flutter/material.dart';
import '../voice_recorder.dart';

class RecordScreen extends StatefulWidget {
  final String date;
  const RecordScreen({super.key, required this.date});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final VoiceRecorder recorder = VoiceRecorder();
  String? recordedPath;
  bool isRecording = false;

  void toggleRecord() async {
    if (isRecording) {
      final result = await recorder.stopAndUploadRecording(recordedPath!, 'user123', widget.date);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Uploaded! Summary: ${result?['summary'] ?? 'N/A'}')),
      );
    } else {
      final path = await recorder.startRecording();
      setState(() => recordedPath = path);
    }
    setState(() => isRecording = !isRecording);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record')),
      body: Center(
        child: ElevatedButton(
          onPressed: toggleRecord,
          child: Text(isRecording ? 'Stop & Upload' : 'Start Recording'),
        ),
      ),
    );
  }
}