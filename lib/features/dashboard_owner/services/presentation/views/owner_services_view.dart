import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/services/data/models/owner_service_model.dart';
import 'package:digital_product/features/dashboard_owner/services/presentation/widgets/owner_services_section.dart';
import 'package:flutter/material.dart';

class OwnerServicesView extends StatelessWidget {
  const OwnerServicesView({super.key});

  static const List<OwnerServiceModel> _generalServices = [
    OwnerServiceModel(
      name: 'التحرير اللغوي',
      price: '3',
      unit: 'لكل صفحة',
      paymentInfo: 'دفع بعد',
      isEnabled: true,
      category: 'الخدمات المتاحة',
    ),
    OwnerServiceModel(
      name: 'التدقيق اللغوي',
      price: '4',
      unit: 'لكل صفحة',
      paymentInfo: 'دفع بعد',
      isEnabled: true,
      category: 'الخدمات المتاحة',
    ),
    OwnerServiceModel(
      name: 'التدقيق الإملائي',
      price: '2',
      unit: 'لكل صفحة',
      paymentInfo: 'دفع مسبق',
      isEnabled: false,
      category: 'الخدمات المتاحة',
    ),
  ];

  static const List<OwnerServiceModel> _educationServices = [
    OwnerServiceModel(
      name: 'حل الواجبات',
      price: '20',
      unit: 'لكل واجب',
      paymentInfo: 'حسب نوع الواجب',
      isEnabled: true,
      category: 'الخدمات التعليمية',
    ),
    OwnerServiceModel(
      name: 'تلخيص الأبحاث',
      price: '15',
      unit: 'لكل صفحة',
      paymentInfo: 'حسب عدد الصفحات',
      isEnabled: true,
      category: 'الخدمات التعليمية',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                child: AppText.title(
                  'إدارة الخدمات',
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            OwnerServicesSection(
              title: 'الخدمات المتاحة',
              services: _generalServices,
            ),
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
            OwnerServicesSection(
              title: 'الخدمات التعليمية',
              services: _educationServices,
            ),
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
          ],
        ),
      ),
    );
  }
}
