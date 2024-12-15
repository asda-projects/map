abstract class SearchMusicInterface {
  Future<void> reproduceAudio(String videoId);
  Future<List<Map<String, dynamic>>> searchVideos(String query);
  Future<List<Map<String, dynamic>>> reproduceMusic(String userId, String videoId);  
}
