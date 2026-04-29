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
    // 1. جعلنا الدالة async هنا أيضاً
    if (err.response?.statusCode == 401) {
      // 2. استخدمنا await عند مسح البيانات
      await SecureStorage().clear();

      // يمكنك هنا إضافة Logic لتوجيه المستخدم لصفحة الـ Login لو حابب
      // Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    }

    handler.next(err);
  }
}
