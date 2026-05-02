import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habispace/features/profile/presentation/Cubit/cubit/profile_cubit.dart';
import 'package:habispace/features/profile/presentation/UI/widgets/SectionTitle.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        
        if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        
        if (state is ProfileLoaded) {
          final user = state.profile.isNotEmpty ? state.profile.first : null;

          return Scaffold(
            backgroundColor: const Color(0xFFF9F9F9),
            body: CustomScrollView(
              slivers: [
                const _ProfileHeader(),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          user?.name ?? 'User Name',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          user?.location?.isNotEmpty == true 
                              ? user!.location 
                              : 'No location set',
                          style: const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const SizedBox(height: 15),

                        buildSectionTitle('Account Setting'),
                        buildMenuItem(
                          Icons.person_outline,
                          'Personal Information',
                        ),
                        buildMenuItem(Icons.key_outlined, 'My Account'),

                        const SizedBox(height: 20),
                        buildSectionTitle('Payment'),
                        buildMenuItem(
                          Icons.credit_card_outlined,
                          'Payment Method',
                        ),

                        const SizedBox(height: 20),
                        buildSectionTitle('Setting & Security'),
                        buildMenuItem(Icons.lock_outline, 'Change Password'),
                        buildMenuItem(
                          Icons.notifications_none_outlined,
                          'Notification Preference',
                        ),

                        buildMenuItem(
                          Icons.delete_outline,
                          'Delete Account',
                          isDestructive: true,
                          onTap: () {
                           context.read<ProfileCubit>().deleteProfile();
                          //  Navigator.pushreplacment(sign in )
                          }
                        ),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // Default fallback
        return const Scaffold(
          body: Center(child: Text('Something went wrong')),
        );
      },
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 220,
      backgroundColor: Colors.white,
      elevation: 0,
      pinned: false, // يفضل موجود لما تعمل سكرول
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Image.network(
                    'https://i.pinimg.com/736x/1d/a5/22/1da522be47c880e198dc87f77133d649.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 110,
              left: 20,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://i.pinimg.com/736x/1d/a5/22/1da522be47c880e198dc87f77133d649.jpg',
                  ),
                ),
              ),
            ),
            // أيقونة التعديل (القلم)
            Positioned(
              bottom: 10,
              right: 20,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 18,
                child: Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
