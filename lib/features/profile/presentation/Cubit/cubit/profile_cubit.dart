import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:habispace/features/profile/domain/Use%20Cases/Delete_Profile_Usecae.dart';
import 'package:habispace/features/profile/domain/Use%20Cases/Get_Profile_Usecase.dart';
import 'package:habispace/features/profile/domain/entities/Profile_Entity.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUsecase getProfileUsecase;
  final  DeleteProfileUsecae deleteAccount;
  ProfileCubit({
    required this.deleteAccount,
    required this.getProfileUsecase
  }) : super(ProfileInitial());
  
  void getProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await getProfileUsecase.call();
      print('Profile loaded: ${profile.name}, ${profile.email}'); // Debug
      emit(ProfileLoaded([profile]));
    } catch (e) {
      print('Profile error: $e'); // Debug
      emit(ProfileInitial());
    }
  }

  void deleteProfile()async{
     emit(ProfileLoading());
    try {
      await deleteAccount.execute();
      emit(ProfileDeleted());
    } catch (e) {
      // Handle error - you may want to add ProfileError state
      emit(ProfileInitial());
    }
  }
}
