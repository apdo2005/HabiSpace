import 'package:go_router/go_router.dart';
import 'package:habispace/features/layout/mainlayout/presentation/ui/main_layout.dart';

abstract class AppRoutes {
  static const String home = '/';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const MainLayout(),
    ),
  ],
);
