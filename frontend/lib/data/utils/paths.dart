


class DirPath {

  static final media = "lib/presentation/assets/media/";


}

// Define the private class
class _Routes {
  const _Routes._(); // Private constructor


  String reproduceAudio() {
    return "/reproduce/music/";
  }

  String searchVideos() {
    return "/search/videos";
  }

  String searchCoverImage() {
    return "/search/music_cover_image/";
  }

  String uploadAudio() {
    return "/firestore/upload_music/";
  }

}

class ExternalPath {
  

  static final youtubeWatchVideo = 'http://youtube.com/watch?v=';

}

class LocalApiPath {
  // Base URL details
  static const _url = '192.168.2.42';
  static const _port = 5000;

  static const baseUrl = '$_url:$_port';

  // Expose a private class through a static getter
  static _Routes get routes => _createRoutes();

  // Private method returning a private class
  static _Routes _createRoutes() => const _Routes._();
}

