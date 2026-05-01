import 'package:dio/dio.dart';
import 'package:habispace/core/constants/secure_storage.dart';
import 'package:habispace/core/constants/storage_keys.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? token =
        await SecureStorage().getString(StorageKeys.authToken) ??
        await SecureStorage().getString('token');

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // استكمال الطلب
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
 
    }

    handler.next(err);
  }
}
