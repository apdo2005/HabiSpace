import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:habispace/core/error/app_exception.dart';
import 'package:habispace/features/profile/domain/Use%20Cases/Delete_Profile_Usecae.dart';
import 'package:habispace/features/profile/domain/Use%20Cases/Get_Profile_Usecase.dart';
import 'package:habispace/features/profile/domain/entities/Profile_Entity.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUsecase getProfileUsecase;
  final DeleteProfileUsecae deleteAccount;

  ProfileCubit({
    required this.deleteAccount,
    required this.getProfileUsecase,
  }) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await getProfileUsecase.call();
      emit(ProfileLoaded([profile]));
    } catch (e) {
      emit(ProfileError(handleException(e).message));
    }
  }

  Future<void> deleteProfile() async {
    emit(ProfileLoading());
    try {
      await deleteAccount.execute();
      emit(ProfileDeleted());
    } catch (e) {
      emit(ProfileError(handleException(e).message));
    }
  }
}
