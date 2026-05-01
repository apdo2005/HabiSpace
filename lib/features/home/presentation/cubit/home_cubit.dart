import 'package:bloc/bloc.dart';

import '../../domain/entity/filter_entity.dart';
import '../../domain/entity/home_entity.dart';
import '../../domain/entity/property_entity.dart';
import '../../domain/usecases/filter_properties_usecase.dart';
import '../../domain/usecases/get_home_usecase.dart';
import '../../domain/usecases/search_properties_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeUseCase getHomeUseCase;
  final SearchPropertiesUseCase searchPropertiesUseCase;
  final FilterPropertiesUseCase filterPropertiesUseCase;


  HomeCubit(this.getHomeUseCase, this.searchPropertiesUseCase, this.filterPropertiesUseCase) : super(HomeInitial());

  FilterEntity _activeFilter = const FilterEntity();
  FilterEntity get activeFilter => _activeFilter;

  Future<void> getHome() async {
    emit(HomeLoading());
    try {
      final home = await getHomeUseCase();
      emit(HomeSuccess(
        home: home,
        selectedTab: 0,
        filteredBestSelling: home.bestSelling,
        filteredFeatured: home.featured,
        filteredRecommended: home.recommended,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void filterByCategory(int tabIndex) {
    final currentState = state;
    if (currentState is! HomeSuccess) return;

    final home = currentState.home;

    if (tabIndex == 0) {
      emit(HomeSuccess(
        home: home,
        selectedTab: 0,
        filteredBestSelling: home.bestSelling,
        filteredFeatured: home.featured,
        filteredRecommended: home.recommended,
      ));
      return;
    }

    final selectedCategory = home.categories[tabIndex - 1];

    List<PropertyEntity> filter(List<PropertyEntity> list) =>
        list.where((p) => p.category.id == selectedCategory.id).toList();

    emit(HomeSuccess(
      home: home,
      selectedTab: tabIndex,
      filteredBestSelling: filter(home.bestSelling),
      filteredFeatured: filter(home.featured),
      filteredRecommended: filter(home.recommended),
    ));
  }

  Future<void> searchProperties(String query) async {
    if (query.isEmpty) {
      getHome();
      return;
    }
    emit(HomeSearchLoading());
    try {
      final results = await searchPropertiesUseCase(query);
      emit(HomeSearchSuccess(results: results, query: query));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }


  Future<void> applyFilter(FilterEntity filter) async {
    _activeFilter = filter;
    emit(HomeLoading());
    try {
      final results = await filterPropertiesUseCase(filter);
      emit(HomeSearchSuccess(results: results, query: ''));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void clearFilter() {
    _activeFilter = const FilterEntity();
    getHome();
  }



}



