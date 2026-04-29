class ApiConstant {
  /// Base URL for API endpoints
  static const String baseUrl = 'https://real.newcinderella.online/api/v1/';

  /// Fake Token
  
  /// API endpoints
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String getProfile = '/profile';
  static const String signup = '/auth/register';
 

  /// Timeout duration in seconds
  static const int connectTimeout = 30;
  static const int receiveTimeout = 30;

  /// Headers
  static const Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
}
