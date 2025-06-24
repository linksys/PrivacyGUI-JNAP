class UrlUtils {
  static bool isValidUrl(String url) {
    if (url.trim() != url || url.contains(' ')) {
      return false;
    }
    try {
      final uri = Uri.parse(url);
      if (!['http', 'https'].contains(uri.scheme)) {
        return false;
      }
      if (uri.host.isEmpty) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}