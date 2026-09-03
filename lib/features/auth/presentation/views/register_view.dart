import 'package:digital_product/features/auth/presentation/widgets/acount_type.dart';
import 'package:digital_product/features/auth/presentation/widgets/register_actions_section.dart';
import 'package:digital_product/features/auth/presentation/widgets/register_fields.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../widgets/auth_header.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _accountType = ValueNotifier<AcountType>(AcountType.customer);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _accountType.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('RegisterView build called');
    print('===================================================');
    return Scaffold(
      backgroundColor: AppColors.appBackground,

      body: Center(
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final horizontalPadding = constraints.maxWidth < 420
                    ? 20.0
                    : 28.0;

                return SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    AppSpacing.sm,
                    horizontalPadding,
                    AppSpacing.xl,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 430),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AuthHeader(),

                            const Gap(AppSpacing.xs),

                            const AppText(
                              'أدخل بياناتك لإنشاء حساب جديد',
                              fontSize: 15,
                              height: 1.6,
                              color: AppColors.bodyText,
                              textAlign: TextAlign.right,
                            ),

                            const Gap(AppSpacing.lg),
                            AccountTypeSelector(
                              valueListenable: _accountType,
                              onChanged: (accountType) {
                                _accountType.value = accountType;
                              },
                            ),
                            const Gap(AppSpacing.lg),

                            RegisterFields(
                              nameController: _nameController,
                              emailController: _emailController,
                              phoneController: _phoneController,
                              passwordController: _passwordController,
                            ),

                            RegisterActionsSection(onRegisterPressed: () {}),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
