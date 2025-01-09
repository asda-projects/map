

import 'package:frontend/data/local/interface_api_music.dart';
import 'package:frontend/data/utils/requests.dart';
import 'package:frontend/data/utils/paths.dart';


class MusicAdapter implements ApiMusicInterface {



  final Request request = Request(baseUrl: LocalApiPath.baseUrl, useHttps: false);
  



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
    throw Exception('Failed to search videos, status code ${response['statusCode']}');
  }
}

  @override
  Future<MyHttpResponse> reproduceAudio(String userId, String videoId) async {
    final response = await request.get(
      "${LocalApiPath.routes.reproduceAudio()}$userId/$videoId"
      
    );

    if (response['statusCode'] == 200) {
    final body = response['body'];
      
      if (body is Map<String, dynamic> && body['data'] is String) {
        return MyHttpResponse(success: true, data:  body['data'], error: body['error']);
    
    } else if (response['statusCode'] == 404) {
      return MyHttpResponse(success: false, data:  body['data'], error: body['error']);

    } else  {
      throw Exception(body['error']);
    }
  } else {
    throw Exception('Failed to reproduce audio, status code ${response['statusCode']}');
  }

  }
  
  @override
  Future<MyHttpResponse> uploadAudio(String userId, String videoId) async {
    final response = await request.get(
      "${LocalApiPath.routes.uploadAudio()}$userId/$videoId"
    );

    if (response['statusCode'] == 200) {
    final body = response['body'];
      if (body is Map<String, dynamic> && body['data'] is String) {
        return MyHttpResponse(success: true, data:  body['data'], error: body['error']);

    } else if (response['statusCode'] == 204) {
      return MyHttpResponse(success: false, data:  body['data'], error: body['error']);

  } else  {
      throw Exception(body['error']);
    }
  } else {
    throw Exception('Failed to reproduce audio, status code ${response['statusCode']}');
  }
 }

 @override
 Future<MyHttpResponse> likeMusic(Map data) async {

    final response = await request.get(
    LocalApiPath.routes.likeMusic(),
    params: {
      "channel": data["channel"], 
      "duration": data["duration"], 
      "title": data["title"],
      "video_id": data["video_id"],
      "views": data["views"], 
      "userId": data["userId"]
      }
  );
    print(response);
    return MyHttpResponse(success: true, data:  response, error: 'error');
 }

}