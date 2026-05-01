import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habispace/core/constants/dio_helper.dart';
import 'package:habispace/core/constants/images_pathes.dart';
import 'package:habispace/features/Favorite/Data/FavoriteRemoteDataSource.dart';
import 'package:habispace/features/Favorite/Data/FavoriteRepositoryImpl.dart';
import 'package:habispace/features/Favorite/Domain/Use%20Cases/Get_list_favourite.dart';
import 'package:habispace/features/Favorite/Domain/Use%20Cases/Remove_favourite.dart';
import 'package:habispace/features/Favorite/Presentation/Cubit/FavoriteCubit/favorite_cubit_cubit.dart';
import 'package:habispace/features/Favorite/Presentation/Pages/favorite_categories_page.dart';
import 'package:habispace/features/History/data/history_data_source_impl.dart';
import 'package:habispace/features/History/data/history_repo_impl.dart';
import 'package:habispace/features/History/domain/Use%20Cases/Get_Orders.dart';
import 'package:habispace/features/History/presentation/Cubit/cubit/history_cubit.dart';
import 'package:habispace/features/History/presentation/UI/History_page.dart';
import 'package:habispace/features/home/data/datasource/home_remote_datasource.dart';
import 'package:habispace/features/home/data/home_repo_impl/home_repo_impl.dart';
import 'package:habispace/features/home/domain/usecases/filter_properties_usecase.dart';
import 'package:habispace/features/home/domain/usecases/get_home_usecase.dart';
import 'package:habispace/features/home/domain/usecases/search_properties_usecase.dart';
import 'package:habispace/features/home/presentation/cubit/home_cubit.dart';
import 'package:habispace/features/home/presentation/ui/home_page.dart';
import 'package:habispace/utils/app_color.dart';
import '../widgets/header.dart';

// ─────────────────────────────────────────────────────────────────────────────
// To add a new tab:
//   1. Add its icon to _navIcons
//   2. Add its label to _navLabels
//   3. Add its page widget to _pages (same order)
//   4. Add its cubit to _initCubits() and _disposeCubits() if needed
//   5. Add BlocProvider.value in MultiBlocProvider if needed
// ─────────────────────────────────────────────────────────────────────────────

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  // ── Cubits ──────────────────────────────────────────────────────────────────
  late final HomeCubit _homeCubit;
  late final FavoriteCubit _favoriteCubit;
  late final HistoryCubit _historyCubit;
        
  @override
  void initState() {
    super.initState();
    _homeCubit = HomeCubit(
      GetHomeUseCase(HomeRepoImpl(HomeRemoteDataSourceImpl())),
      SearchPropertiesUseCase(HomeRepoImpl(HomeRemoteDataSourceImpl())),
      FilterPropertiesUseCase(HomeRepoImpl(HomeRemoteDataSourceImpl())),
    )..getHome();

    final favRepo = FavoriteRepositoryImpl(
      FavoriteRemoteDataSourceImpl(DioHelper.dio),
    );
    _favoriteCubit = FavoriteCubit(
      getListFavoriteUseCase: GetListFavoriteUseCase(favRepo),
      removeFavouriteUseCase: RemoveFavouriteUseCase(favRepo),
    )..getFavorites();

    _historyCubit = HistoryCubit(
      GetOrders(HistoryRepoImpl(historyDataSource: HistoryDataSourceImpl())),
    )..getHistory();
  }

  @override
  void dispose() {
    _homeCubit.close();
    _favoriteCubit.close();
    _historyCubit.close();
    super.dispose();
  }

  // ── Nav items — add new tab here ────────────────────────────────────────────
  static const _navIcons = [
    ImagesPathes.home,     // 0
    ImagesPathes.favo,     // 1
    ImagesPathes.hestory,  // 2
    ImagesPathes.map,      // 3
  ];

  static const _navLabels = [
    'Home',       // 0
    'Favourites', // 1
    'History',    // 2
    'Map',        // 3
  ];

  // ── Tab pages — must match nav items order ──────────────────────────────────
  List<Widget> get _pages => [
    const HomePage(),               // 0 — Home
    const FavoriteCategoriesPage(), // 1 — Favourites
    const HistoryPage(),            // 2 — History
    const _PlaceholderTab(label: 'Map'), // 3 — Map
  ];

  // ── Build ───────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _homeCubit),
        BlocProvider.value(value: _favoriteCubit),
        BlocProvider.value(value: _historyCubit),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.lightGrayColor,
          body: SafeArea(
            child: Column(
              children: [
                Header(currentTabIndex: _currentIndex),
                Expanded(
                  child: IndexedStack(
                    index: _currentIndex,
                    children: _pages,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: _BottomNav(
            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
          ),
        ),
      ),
    );
  }
}

// ── Bottom nav ────────────────────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const _BottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: List.generate(
          _MainLayoutState._navIcons.length,
          (i) => BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _MainLayoutState._navIcons[i],
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                currentIndex == i ? AppColors.blue : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            label: _MainLayoutState._navLabels[i],
          ),
        ),
      ),
    );
  }
}

// ── Placeholder tab ───────────────────────────────────────────────────────────

class _PlaceholderTab extends StatelessWidget {
  final String label;
  const _PlaceholderTab({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
      ),
    );
  }
}
