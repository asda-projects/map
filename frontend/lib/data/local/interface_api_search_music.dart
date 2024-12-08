abstract class SearchMusicInterface {
  Future<void> streamAudio(String videoId);
  Future<void> reproduceAudio(String videoId);
  Future<List<Map<String, dynamic>>> searchVideos(String query);
}
