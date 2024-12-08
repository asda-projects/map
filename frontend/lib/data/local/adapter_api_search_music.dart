

import 'package:frontend/data/local/interface_api_search_music.dart';
import 'package:frontend/data/utils/requests.dart';

class MusicService implements SearchMusicInterface {
  final Request request = Request(baseUrl: 'localhost:5000', useHttps: false);

  @override
  Future<void> streamAudio(String videoId) async {
    final response = await request.get('/stream/$videoId', headers: {
      'Content-Type': 'audio/mpeg',
    });

    if (response['statusCode'] != 200) {
      throw Exception('Failed to stream audio');
    }
  }

  @override
  Future<void> reproduceAudio(String videoId) async {
    final response = await request.get('/reproduce/$videoId', headers: {
      'Content-Type': 'audio/mp4',
    });

    if (response['statusCode'] != 200) {
      throw Exception('Failed to reproduce audio');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> searchVideos(String query) async {
    final response = await request.get('/search', params: {'query': query});

    if (response['statusCode'] == 200 && response['body'] is Map<String, dynamic>) {
      final List<dynamic> results = response['body']['results'] ?? [];
      return results.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to search videos');
    }
  }
}
