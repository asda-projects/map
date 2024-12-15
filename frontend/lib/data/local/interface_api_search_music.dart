import 'package:frontend/data/utils/requests.dart';

abstract class SearchMusicInterface {
  Future<List<Map<String, dynamic>>> searchVideos(String query);
  Future<MyHttpResponse> reproduceAudio(String userId, String videoId);
  Future<MyHttpResponse> uploadAudio(String userId, String videoId);  
}
