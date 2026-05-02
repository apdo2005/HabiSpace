import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:habispace/features/auth/data/datasource/auth_datasource_impl.dart';
import 'package:habispace/features/auth/data/repository/auth_repository_impl.dart';
import 'package:habispace/features/auth/domain/repository/auth_repository.dart';
import 'package:habispace/features/auth/presentation/logic/auth_bloc.dart';

import '../../features/auth/data/datasource/auth_datasource.dart';
import '../constants/api_constant.dart';
import '../constants/dio_helper.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  DioHelper.init(baseUrl: ApiConstant.baseUrl);
  sl.registerLazySingleton<Dio>(() => DioHelper.dio);


  sl.registerLazySingleton<AuthDatasource>(() => AuthDatasourceImpl());

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authDatasource: sl()),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(authRepository: sl()),
  );
}
