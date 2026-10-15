import 'package:digital_product/features/dashboard_user/profile/data/models/profile_model.dart';
import 'package:digital_product/features/dashboard_user/profile/domain/usecases/get_profile_usecase.dart';
import 'package:digital_product/features/dashboard_user/profile/domain/usecases/logout_usecase.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/viewmodels/profile_cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getProfileUseCase, this._logoutUseCase)
    : super(const ProfileInitial());

  final GetProfileUseCase _getProfileUseCase;
  final LogoutUseCase _logoutUseCase;

  ProfileModel? _profile;

  Future<void> loadProfile() async {
    emit(const ProfileLoading());
    final result = await _getProfileUseCase();
    if (isClosed) return;

    result.fold(
      (failure) => emit(ProfileFailureState(failure.message)),
      (profile) {
        _profile = profile;
        emit(ProfileSuccess(profile));
      },
    );
  }

  Future<void> logout() async {
    if (state is ProfileLogoutLoading) return;

    final profile = _profile;
    if (profile == null) return;

    emit(ProfileLogoutLoading(profile));
    final result = await _logoutUseCase();
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        ProfileLogoutFailure(profile: profile, message: failure.message),
      ),
      (_) {
        _profile = null;
        emit(const ProfileLogoutSuccess());
      },
    );
  }
}
