import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habispace/core/constants/api_constant.dart';
import 'package:habispace/core/constants/bloc_abserver.dart';
import 'package:habispace/core/constants/dio_helper.dart';
import 'package:habispace/core/constants/secure_storage.dart';
import 'package:habispace/core/constants/storage_keys.dart';
import 'package:habispace/core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ScreenUtil.ensureScreenSize;
  await SecureStorage().setString(
    StorageKeys.authToken,
    '35|KpydfsfMqGrHuIFOAGRe89OitRqMtq3btpdkSfMQee638e93',
  );

  await AuthStorage().init();
  Bloc.observer = AppBlocObserver();
  DioHelper.init(baseUrl: ApiConstant.baseUrl);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'HabiSpace',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
