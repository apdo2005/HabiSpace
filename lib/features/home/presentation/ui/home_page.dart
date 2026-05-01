import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/home_cubit.dart';
import 'home_view.dart';

/// Drop-in widget for the Home tab in MainLayout.
/// Internally uses CustomScrollView + slivers — callers don't need to know.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => CustomScrollView(
        slivers: homeViewSlivers(context, state),
      ),
    );
  }
}
