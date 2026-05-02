import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habispace/core/constants/api_constant.dart';
import 'package:habispace/core/constants/bloc_abserver.dart';
import 'package:habispace/core/constants/dio_helper.dart';
import 'package:habispace/core/constants/secure_storage.dart';
import 'package:habispace/features/on_boarding/on_boarding.dart';
import 'package:habispace/routes.dart';

import 'core/di/di.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/logic/auth_bloc.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await dotenv.load(fileName: ".env");
  await AuthStorage().init();
  Bloc.observer = AppBlocObserver();
  DioHelper.init(baseUrl: ApiConstant.baseUrl);
  await initDependencies();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.generateRoute,
          title: 'HabiSpace',
          theme: AppTheme.lightTheme(),
          home: _getInitialScreen(),
        );
      },
    );
  }

  Widget _getInitialScreen() {
    final storage = AuthStorage();

    if (storage.isOnboardingComplete != true) {
      return const OnBoarding();
    }

    final token = storage.token;
    if (token != null && token.isNotEmpty) {
      return HomeScreen();
    }

    return BlocProvider<AuthBloc>(
      create: (_) => sl<AuthBloc>(),
      child: LoginScreen(),
    );
  }

}