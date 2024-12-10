


class DirPath {

  static final media = "lib/presentation/assets/media/";


}

// Define the private class
class _Routes {
  const _Routes._(); // Private constructor

  String streamAudio() {
    return  "/stream/";
  }

  String reproduceAudio() {
    return "/reproduce/";
  }

  String searchVideos() {
    return "/search";
  }

  String searchImageCover() {
    return "/search_image_music_cover/";
  }

}

class LocalApiPath {
  // Base URL details
  static const _url = '172.20.10.3';
  static const _port = 5000;

  static const baseUrl = '$_url:$_port';

  // Expose a private class through a static getter
  static _Routes get routes => _createRoutes();

  // Private method returning a private class
  static _Routes _createRoutes() => const _Routes._();
}

