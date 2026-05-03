import 'package:bloc/bloc.dart';
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
import 'features/auth/presentation/logic/auth_bloc.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/mainlayout/presentation/ui/main_layout.dart';
import 'features/on_boarding/on_boarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  ScreenUtil.ensureScreenSize;
  await AuthStorage().init();
  Bloc.observer = AppBlocObserver();
  setupLocator();
  DioHelper.init(baseUrl: ApiConstant.baseUrl);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: BlocProvider(
        create: (_) => ThemeCubit()..loadTheme(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              routerConfig: appRouter,
            );
          },
        );
      },
    );
  }
}


