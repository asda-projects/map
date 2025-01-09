import 'dart:convert';
import 'package:frontend/data/local/adapter_api_music.dart';
import 'package:frontend/data/local/adapter_local_cache.dart';




class MusicService {
  static const String _cacheKey = "music_list";
  final LocalCacheAdapter cache;
  final MusicAdapter _musicAdapter = MusicAdapter();
  

  MusicService._(this.cache);

  static Future<MusicService> getInstance(String secretKey) async {
    final cache = await LocalCacheAdapter.getInstance(secretKey);
    return MusicService._(cache);
  }

  // Save Music
  Future<void> saveMusicList(List<Map<String, dynamic>> musicList) async {
    String musicJson = jsonEncode(musicList);
    await cache.saveString(_cacheKey, musicJson);
    
  }

  // Load Music
  Future<List<Map<String, dynamic>>> loadMusic() async {
    String? musicJson = cache.getString(_cacheKey);

    if (musicJson != null) {
      List<dynamic> decodedList = jsonDecode(musicJson);
      List<Map<String, dynamic>> musicList =
          List<Map<String, dynamic>>.from(decodedList);
      
      
      return musicList;
    }

    
    return [];
  }

  Future<List<Map<String, dynamic>>>  searchVideo(String musicName) async {

    final results = await _musicAdapter.searchVideos(musicName);
    
    return results;

  
}
  Future<String> reproduceAudio(String userId, String videoId) async {

    final resultsReproduce = await _musicAdapter.reproduceAudio(userId, videoId);
    
    if (resultsReproduce.success == true) {
      return resultsReproduce.data;

    } else if (resultsReproduce.success == false) {
      final resultsUpload = await _musicAdapter.uploadAudio(userId, videoId);

      return resultsUpload.data;


    } else {
      throw Exception("Error in service of reproducing Audio");
    }
    
  }

  void likeMusic(Map data) {
    _musicAdapter.likeMusic(data);
  }
  

}
