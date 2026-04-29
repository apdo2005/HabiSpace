class ApiConstant {
  /// Base URL for API endpoints
  static const String baseUrl = 'https://grocery.newcinderella.online/api';

  /// Fake Token
  
  /// API endpoints
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String getProfile = '/profile';
  static const String signup = '/auth/register';
  static const String category = '/categories';

  static String detailsOfSubcategories(int id) => '/categories/$id/meals';
  static const String todaysdeals = '/meals/today';
  static const String todayDeals = '/meals/today';
  static const String updateProfile = '/user/profile/update';
  static const String getProducts = '/products';
  static const String getProductDetails = '/products/:di';
  static const String getmeals = '/meals/:id';
  static const String addToCart = '/cart/add';
  static const String removeFromCart = '/cart/remove';
  static const String getCart = '/cart';
  static const String checkout = '/checkout';
  static const String ordersHistory = '/orders';
  static const String getOrderDetails = '/orders/:id';
  static const String getFavorites = '/favorites';
  static const String toggleFavorite = '/favorites/:id/toggle';
  static const String getSmartLists = '/smart-lists';
  static const String smartLists = '/smart-lists';
  static const String smartList = '/smart-lists/:id';
  static const String getOrders = '/orders';
  static const String sendOtp = '/auth/forgot-password';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resetPassword = '/auth/reset-password';

  /// API endpoints
  static const String subcategories = '/subcategories';

  static String meals(int subcategoryId) {
    return "/subcategories/$subcategoryId/meals";
  }

  /// Timeout duration in seconds
  static const int connectTimeout = 30;
  static const int receiveTimeout = 30;

  /// Headers
  static const Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
}
