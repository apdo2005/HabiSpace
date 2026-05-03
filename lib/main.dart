import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habispace/core/constants/api_constant.dart';
import 'package:habispace/core/constants/bloc_abserver.dart';
import 'package:habispace/core/constants/dio_helper.dart';
import 'package:habispace/core/constants/secure_storage.dart';
import 'package:habispace/core/router/app_router.dart';
import 'package:habispace/core/theme/app_theme.dart';
import 'package:habispace/core/theme/theme_cubit.dart';
import 'core/di/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  ScreenUtil.ensureScreenSize;
  await AuthStorage().init();
  Bloc.observer = AppBlocObserver();
  setupLocator();
  DioHelper.init(baseUrl: ApiConstant.baseUrl);

  final initialRoute = _getInitialRoute();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: BlocProvider(
        create: (_) => ThemeCubit()..loadTheme(),
        child: MyApp(initialRoute: initialRoute),
      ),
    ),
  );
}

String _getInitialRoute() {
  final storage = AuthStorage();

  if (storage.isOnboardingComplete != true) {
    return AppRoutes.onBoarding;
  }

  final token = storage.token;
  if (token != null && token.isNotEmpty) {
    return AppRoutes.home;
  }

  return AppRoutes.login;
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'HabiSpace',
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: AppTheme.lightTheme(),
              darkTheme: AppTheme.darkTheme(),
              themeMode: themeMode,
              routerConfig: createRouter(initialRoute),
            );
          },
        );
      },
    );
  }
}