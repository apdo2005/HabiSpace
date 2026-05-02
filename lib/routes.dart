import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habispace/core/di/di.dart';
import 'package:habispace/features/auth/presentation/logic/auth_bloc.dart';
import 'package:habispace/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:habispace/features/auth/presentation/screens/login_screen.dart';
import 'package:habispace/features/auth/presentation/screens/signup_screen.dart';
import 'package:habispace/features/auth/presentation/forget_password/otp_screen.dart';
import 'package:habispace/features/auth/presentation/forget_password/reset_password_screen.dart';
import 'package:habispace/features/home_screen.dart';
import 'package:habispace/features/on_boarding/on_boarding.dart';

class AppRoutes {
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String otp = '/otp';
  static const String resetPassword = '/reset-password';
  static const String home = '/home';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case AppRoutes.onBoarding:
        return _page(const OnBoarding());

      case AppRoutes.login:
        return _pageWithAuth(LoginScreen());

      case AppRoutes.signup:
        return _pageWithAuth(SignupScreen());

      case AppRoutes.forgotPassword:
        return _pageWithAuth(ForgetPasswordScreen());

      case AppRoutes.otp:
        final email = settings.arguments as String;
        return _pageWithAuth(OtpScreen(email: email));

      case AppRoutes.resetPassword:
        final args = settings.arguments as Map<String, String>;
        return _pageWithAuth(
          ResetPasswordScreen(
            email: args['email']!,
            otp: args['otp']!,
          ),
        );

      case AppRoutes.home:
        return _page(const HomeScreen());

      default:
        return _pageWithAuth(LoginScreen());
    }
  }

  static MaterialPageRoute _pageWithAuth(Widget page) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<AuthBloc>(
        create: (_) => sl<AuthBloc>(),
        child: page,
      ),
    );
  }

  static MaterialPageRoute _page(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}