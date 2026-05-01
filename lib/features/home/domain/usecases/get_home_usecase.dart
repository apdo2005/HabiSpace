import '../entity/home_entity.dart';
import '../home_repo/home_repo.dart';

class GetHomeUseCase {
  final HomeRepo repo;

  GetHomeUseCase(this.repo);

  Future<HomeEntity> call() => repo.getHome();
}