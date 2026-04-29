import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habispace/core/constants/api_constant.dart';
import 'package:habispace/core/constants/bloc_abserver.dart';
import 'package:habispace/core/constants/dio_helper.dart';
import 'package:habispace/core/constants/secure_storage.dart';
import 'package:habispace/features/on_boarding/on_boarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ScreenUtil.ensureScreenSize;
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
      designSize: Size(393, 852),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: OnBoarding(),
      ),
    );
  }
}
