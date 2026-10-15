import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/utils/app_snackbar.dart';
import 'package:digital_product/features/dashboard_user/profile/data/models/profile_model.dart';
import 'package:digital_product/features/dashboard_user/profile/data/remote_data_source/edit_profile/edit_profile_remote_data_source.dart';
import 'package:digital_product/features/dashboard_user/profile/data/repositories/edit_profile_repo/edit_profile_repository_impl.dart';
import 'package:digital_product/features/dashboard_user/profile/domain/usecases/update_profile_usecase.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/viewmodels/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/viewmodels/edit_profile_cubit/edit_profile_state.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/viewmodels/profile_cubit/profile_cubit.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/widgets/edit_profile_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileViewBody extends StatefulWidget {
  const EditProfileViewBody({super.key, required this.profile});

  final ProfileModel profile;

  @override
  State<EditProfileViewBody> createState() => _EditProfileViewBodyState();
}

class _EditProfileViewBodyState extends State<EditProfileViewBody> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.profile.name ?? '');

    phoneController = TextEditingController(text: widget.profile.phone ?? '');

    emailController = TextEditingController(text: widget.profile.email ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = MediaQuery.sizeOf(context).width < 600
        ? AppSpacing.md
        : AppSpacing.xl;

    return BlocProvider(
      create: (context) => EditProfileCubit(
        updateProfileUseCase: UpdateProfileUseCase(
          EditProfileRepositoryImpl(
            editProfileRemoteDataSource: EditProfileRemoteDataSourceImpl(),
          ),
        ),
      ),
      child: BlocListener<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccess) {
            _completeProfileUpdate(context, state);

            return;
          }

          if (state is EditProfileFailure) {
            AppSnackbar.error(context, message: state.message);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.appBackground,
          body: SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    AppSpacing.md,
                    horizontalPadding,
                    0,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: EditProfileContent(
                      profile: widget.profile,
                      nameController: nameController,
                      phoneController: phoneController,
                      emailController: emailController,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _completeProfileUpdate(
    BuildContext context,
    EditProfileSuccess state,
  ) async {
    await context.read<ProfileCubit>().loadProfile();
    if (!context.mounted) return;

    if (state.cleanupWarning != null) {
      AppSnackbar.warning(context, message: state.cleanupWarning!);
    } else {
      AppSnackbar.success(
        context,
        message:
            'تم تحديث البيانات. يرجى تأكيد البريد الإلكتروني الجديد من الرسالة المرسلة إليك',
      );
    }

    Navigator.of(context).pop();
  }
}
