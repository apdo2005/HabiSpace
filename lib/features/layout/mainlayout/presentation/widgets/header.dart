import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habispace/core/constants/images_pathes.dart';
import 'package:habispace/features/Favorite/Presentation/Cubit/FavoriteCubit/favorite_cubit_cubit.dart';
import 'package:habispace/features/Favorite/Presentation/Widgets/favorite_filter_sheet.dart';
import 'package:habispace/features/History/presentation/Cubit/cubit/history_cubit.dart';
import 'package:habispace/features/chat/data/chat_repo_impl/chat_repo_impl.dart';
import 'package:habispace/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:habispace/features/chat/domain/usescases/get_conversation_usecase.dart';
import 'package:habispace/features/chat/domain/usescases/send_message_usecase.dart';
import 'package:habispace/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:habispace/features/chat/presentation/ui/chat_view.dart';
import 'package:habispace/features/home/presentation/cubit/home_cubit.dart';
import 'package:habispace/features/home/presentation/widgets/filter_bottom_sheet.dart';
import 'package:habispace/features/notifications/presentation/ui/notification_view.dart';
import 'package:habispace/shared/custom_svg_image.dart';
import 'package:habispace/utils/app_color.dart';
import 'package:habispace/utils/app_sizes.dart';
import 'header_icon_button.dart';

class Header extends StatefulWidget {
  /// 0 = Home, 1 = Favourites, 2 = Map, etc.
  final int currentTabIndex;

  const Header({super.key, this.currentTabIndex = 0});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onFilterTap(BuildContext context) {
    // Tab 1 = Favourites → show favourite category filter
    if (widget.currentTabIndex == 1) {
      try {
        final favCubit = context.read<FavoriteCubit>();
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => BlocProvider.value(
            value: favCubit,
            child: const FavoriteFilterSheet(),
          ),
        );
      } catch (_) {}
      return;
    }

    // Tab 0 = Home (and others) → show home filter
    try {
      final homeCubit = context.read<HomeCubit>();
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => BlocProvider.value(
          value: homeCubit,
          child: _FilterSheet(homeCubit: homeCubit),
        ),
      );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.w20,
        vertical: AppSizes.h12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Location row ──────────────────────────────────────────────
          Row(
            children: [
              CustomSvgImage(
                path: ImagesPathes.locat,
                width: AppSizes.w20,
                height: AppSizes.h20,
                color: AppColors.blue,
              ),
              SizedBox(width: AppSizes.w10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style: TextStyle(
                        fontSize: AppSizes.sp12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textLightColor,
                      ),
                    ),
                    SizedBox(height: AppSizes.h2),
                    Text(
                      'Los Angeles, California',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: AppSizes.sp14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppSizes.w8),
              HeaderIconButton(
                path: ImagesPathes.notifi,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NotificationView(),
                  ),
                ),
              ),
              SizedBox(width: AppSizes.w12),
              HeaderIconButton(
                path: ImagesPathes.chaticon,
                onTap: () {
                  final repo = ChatRepoImpl(ChatRemoteDataSourceImpl());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => ChatCubit(
                          GetConversationUseCase(repo),
                          SendMessageUseCase(repo),
                        ),
                        child: const ChatView(
                          conversationId: 1,
                          agentName: 'Agent',
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),

          SizedBox(height: AppSizes.h12),

          // ── Search bar + filter ───────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrayColor,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: AppColors.textSecondaryColor,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (query) {
                            try {
                              context.read<FavoriteCubit>().search(query);
                            } catch (_) {}
                            try {
                              context.read<HomeCubit>().searchProperties(query);
                            } catch (_) {}
                            try {
                              context.read<HistoryCubit>().search(query);
                            } catch (_) {}
                          },
                          cursorHeight: 15,
                          cursorWidth: 2,
                          cursorColor: AppColors.blue,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search your home',
                            hintStyle: TextStyle(
                              color: AppColors.textSecondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _searchController,
                        builder: (_, value, child) {
                          if (value.text.isEmpty) return const SizedBox.shrink();
                          return GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              try {
                                context.read<FavoriteCubit>().search('');
                              } catch (_) {}
                              try {
                                context.read<HomeCubit>().searchProperties('');
                              } catch (_) {}
                              try {
                                context.read<HistoryCubit>().search('');
                              } catch (_) {}
                            },
                            child: const Icon(
                              Icons.close,
                              size: 18,
                              color: AppColors.textSecondaryColor,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: AppSizes.w10),
              // ── Filter button ─────────────────────────────────────────
              HeaderIconButton(
                path: ImagesPathes.filter,
                onTap: () => _onFilterTap(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Filter sheet wrapper ──────────────────────────────────────────────────────

class _FilterSheet extends StatelessWidget {
  final HomeCubit homeCubit;
  const _FilterSheet({required this.homeCubit});

  @override
  Widget build(BuildContext context) {
    return FilterBottomSheet(initialFilter: homeCubit.activeFilter);
  }
}
