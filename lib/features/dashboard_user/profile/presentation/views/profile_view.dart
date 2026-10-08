import 'package:digital_product/features/dashboard_user/profile/data/remote_data_source/get_profile.dart/get_profile_remote_data_source.dart';
import 'package:digital_product/features/dashboard_user/profile/data/repositories/profile_repo/profile_repository_impl.dart';
import 'package:digital_product/features/dashboard_user/profile/domain/usecases/get_profile_usecase.dart';
import 'package:digital_product/features/dashboard_user/profile/domain/usecases/logout_usecase.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/viewmodels/profile_cubit/profile_cubit.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final repository = ProfileRepositoryImpl(ProfileRemoteDataSourceImpl());
        return ProfileCubit(
          GetProfileUseCase(repository),
          LogoutUseCase(repository),
        )..loadProfile();
      },
      child: const ProfileViewBody(),
    );
  }
}
