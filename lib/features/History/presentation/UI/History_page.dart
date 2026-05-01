import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habispace/features/History/presentation/Cubit/cubit/history_cubit.dart';
import 'package:habispace/shared/custom_svg_image.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          /// 🔄 Loading
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          /// ❌ Error
          if (state is HistoryError) {
            return Center(child: Text(state.error));
          }

          /// ✅ Success
          if (state is HistorySuccess) {
            final orders = state.filtered;

            /// 🟡 Empty state
            if (orders.isEmpty) {
              return const Center(child: Text("No History Yet"));
            }

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final property = order.property;

                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 🖼️ IMAGE
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        child: property.images.isNotEmpty
                            ? CustomSvgImage(
                                path: property.images[0],
                                width: double.infinity,
                                height: 180,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: double.infinity,
                                height: 180,
                                color: Colors.grey[200],
                                child: const Icon(
                                  Icons.home,
                                  color: Colors.grey,
                                  size: 48,
                                ),
                              ),
                      ),

                      /// 📄 CONTENT
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// 🏠 TITLE + STATUS BADGE
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    property.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                _StatusBadge(status: order.status),
                              ],
                            ),

                            const SizedBox(height: 6),

                            /// 📍 LOCATION
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined,
                                    size: 16, color: Colors.grey),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    property.address,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            /// 🏷️ DETAILS
                            Wrap(
                              spacing: 12,
                              runSpacing: 8,
                              children: [
                                _InfoItem(
                                  icon: Icons.bed,
                                  text:
                                      '${property.bedrooms} Bedroom${property.bedrooms != 1 ? 's' : ''}',
                                ),
                                _InfoItem(
                                  icon: Icons.bathtub,
                                  text:
                                      '${property.bathrooms} Bathroom${property.bathrooms != 1 ? 's' : ''}',
                                ),
                                _InfoItem(
                                  icon: Icons.category_outlined,
                                  text: property.categoryName,
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            /// 💰 AMOUNT + DATE
                            Row(
                              children: [
                                Text(
                                  '\$${order.amount}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  ' ${" "}',
                                ),
                                Text(
                                  order.currency.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(Icons.calendar_today_outlined,
                                    size: 14, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  order.createdAt.substring(0, 10),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          /// 🟢 Initial state
          return const SizedBox();
        },
      ),
    );
  }
}

// ── Status Badge ──────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final color = switch (status.toLowerCase()) {
      'completed' => Colors.green,
      'pending' => Colors.orange,
      'cancelled' => Colors.red,
      _ => Colors.grey,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ── Info Item ─────────────────────────────────────────────────────────────────

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
