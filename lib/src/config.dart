enum AuthType {
  basic,
  token,
}
// JNAP configuration
class Config {
  static bool isRelease = false;
  static String baseUrl = 'localhost';
  static String path = '';
  static Map<String, String> extraHeaders = {};
  static String auth = '';
  static AuthType authType = AuthType.basic;
}
