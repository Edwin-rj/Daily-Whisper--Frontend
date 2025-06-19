import 'dart:io';
import 'dart:convert';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VoiceRecorder {
  final Record _record = Record();

  Future<String?> startRecording() async {
    final hasPermission = await _record.hasPermission();
    if (!hasPermission) return null;

    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

    await _record.start(
      path: path,
      encoder: AudioEncoder.aacLc,
      bitRate: 128000,
      samplingRate: 44100,
    );

    return path;
  }

  Future<Map<String, dynamic>?> stopAndUploadRecording(String localPath, String userId, String date) async {
    await _record.stop();

    final file = File(localPath);
    final fileName = 'voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
    final storageRef = FirebaseStorage.instance.ref().child('recordings/$fileName');
    await storageRef.putFile(file);
    final url = await storageRef.getDownloadURL();

    final uri = Uri.parse('https://daily-whispers-bknd.onrender.com/api/process-audio'); // Replace with your actual backend
    final response = await http.post(
      uri,
      headers: { 'Content-Type': 'application/json' },
      body: jsonEncode({
        'audioUrl': url,
        'userId': userId,
        'date': date
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'audioUrl': url,
        'transcript': data['transcript'],
        'summary': data['summary']
      };
    }
    return null;
  }
}
