

import 'package:frontend/data/local/interface_api_search_music.dart';
import 'package:frontend/data/utils/requests.dart';
import 'package:frontend/data/utils/paths.dart';

class MusicAdapter implements SearchMusicInterface {



  final Request request = Request(baseUrl: LocalApiPath.baseUrl, useHttps: false);
  

  @override
  Future<void> reproduceAudio(String videoId) async {
    final response = await request.get('${
      LocalApiPath.routes.reproduceAudio()
      }$videoId', headers: {
      'Content-Type': 'audio/mp4',
    });

    if (response['statusCode'] != 200) {
      throw Exception('Failed to reproduce audio');
    }
  }

  @override
Future<List<Map<String, dynamic>>> searchVideos(String query) async {
  final response = await request.get(
    LocalApiPath.routes.searchVideos(),
    params: {'query': query},
  );

  
  

  if (response['statusCode'] == 200) {
    final body = response['body'];
    

    if (body is Map<String, dynamic> && body['data'] is List) {
      final results = body['data'] as List<dynamic>;
      return results.map((e) => Map<String, dynamic>.from(e)).toList();
    } else {
      throw Exception('Invalid data format from the server');
    }
  } else {
    throw Exception('Failed to search videos: ${response['statusCode']}');
  }
}

  @override
  Future<List<Map<String, dynamic>>> reproduceMusic(String userId, String videoId) {
    final response = await 

  }


}

