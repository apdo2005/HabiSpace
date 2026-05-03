import 'package:get_it/get_it.dart';
import '../../features/auth/data/datasource/auth_datasource.dart';
import '../../features/auth/data/datasource/auth_datasource_impl.dart';
import '../../features/auth/data/repository/auth_repository_impl.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/presentation/logic/auth_bloc.dart';
import '../../features/chat/data/chat_repo_impl/chat_repo_impl.dart';
import '../../features/chat/data/datasource/chat_remote_datasource.dart';
import '../../features/chat/domain/chat_repo/chat_repo.dart';
import '../../features/chat/domain/usescases/get_conversation_usecase.dart';
import '../../features/chat/domain/usescases/send_message_usecase.dart';
import '../../features/chat/presentation/cubit/chat_cubit.dart';
import '../../features/favorite/data/datasource/FavoriteRemoteDataSource.dart';
import '../../features/favorite/data/favo_repo_impl/FavoriteRepositoryImpl.dart';
import '../../features/favorite/domain/repositories/Favorite_repository.dart';
import '../../features/favorite/domain/useCases/Add_to_favourite.dart';
import '../../features/favorite/domain/useCases/Get_list_favourite.dart';
import '../../features/favorite/domain/useCases/Remove_favourite.dart';
import '../../features/favorite/presentation/cubit/FavoriteCubit/favorite_cubit_cubit.dart';
import '../../features/History/data/history_data_source.dart';
import '../../features/History/data/history_data_source_impl.dart';
import '../../features/History/data/history_repo_impl.dart';
import '../../features/History/domain/Repository/history_repo.dart';
import '../../features/History/domain/Use Cases/Get_Orders.dart';
import '../../features/History/presentation/Cubit/cubit/history_cubit.dart';
import '../../features/home/data/datasource/home_remote_datasource.dart';
import '../../features/home/data/home_repo_impl/home_repo_impl.dart';
import '../../features/home/domain/home_repo/home_repo.dart';
import '../../features/home/domain/usecases/filter_properties_usecase.dart';
import '../../features/home/domain/usecases/get_home_usecase.dart';
import '../../features/home/domain/usecases/search_properties_usecase.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/profile/data/datasource/Profile_data_source_impl.dart';
import '../../features/profile/data/repo/Profile_repo_impl.dart';
import '../../features/profile/domain/Repository/Profile_repo.dart';
import '../../features/profile/domain/Use Cases/Delete_Profile_Usecae.dart';
import '../../features/profile/domain/Use Cases/Get_Profile_Usecase.dart';
import '../../features/profile/presentation/Cubit/cubit/profile_cubit.dart';


final sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(),);
  sl.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(sl()),);
  sl.registerLazySingleton(() => GetHomeUseCase(sl()));
  sl.registerLazySingleton(() => SearchPropertiesUseCase(sl()));
  sl.registerLazySingleton(() => FilterPropertiesUseCase(sl<HomeRepo>()));
  sl.registerFactory(() => HomeCubit(sl(), sl(), sl()));

  sl.registerLazySingleton<FavoriteRemoteDataSource>(() => const FavoriteRemoteDataSourceImpl());
  sl.registerLazySingleton<FavoriteRepository>(() => FavoriteRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetListFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => AddToFavouriteUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFavouriteUseCase(sl()));
  sl.registerFactory(() => FavoriteCubit(
    getListFavoriteUseCase: sl(),
    addToFavouriteUseCase: sl(),
    removeFavouriteUseCase: sl(),
  ));

  sl.registerFactory(() => ChatCubit(sl(), sl(),));
  sl.registerLazySingleton(() => GetConversationUseCase(sl<ChatRepo>()));
  sl.registerLazySingleton(() => SendMessageUseCase(sl<ChatRepo>()));
  sl.registerLazySingleton<ChatRepo>(() => ChatRepoImpl(sl<ChatRemoteDataSource>()));
  sl.registerLazySingleton<ChatRemoteDataSource>(() => ChatRemoteDataSourceImpl());

  sl.registerLazySingleton<AuthDatasource>(() => AuthDatasourceImpl());
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(authDatasource: sl()),
  );
  sl.registerFactory<AuthBloc>(
        () => AuthBloc(authRepository: sl()),
  );

  // History
  sl.registerLazySingleton<HistoryDatasource>(() => HistoryDataSourceImpl());
  sl.registerLazySingleton<HistoryRepo>(
    () => HistoryRepoImpl(historyDataSource: sl<HistoryDatasource>()),
  );
  sl.registerLazySingleton(() => GetOrders(sl<HistoryRepo>()));
  sl.registerFactory(() => HistoryCubit(sl<GetOrders>()));

  // Profile
  sl.registerLazySingleton<ProfileDataSourceImpl>(() => ProfileDataSourceImpl());
  sl.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(repo: sl<ProfileDataSourceImpl>()),
  );
  sl.registerLazySingleton(() => GetProfileUsecase(repository: sl<ProfileRepo>()));
  sl.registerLazySingleton(() => DeleteProfileUsecae(sl<ProfileRepo>()));
  sl.registerFactory(() => ProfileCubit(
    getProfileUsecase: sl<GetProfileUsecase>(),
    deleteAccount: sl<DeleteProfileUsecae>(),
  ));
}