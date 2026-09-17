import 'dart:async';
import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_show_model_bottom_sheet.dart';
import 'package:digital_product/features/services/data/models/service_model.dart';
import 'package:digital_product/features/services/presentation/widgets/service_order_bottom_sheet.dart';
import 'package:digital_product/features/services/presentation/widgets/services_silver_app_bar.dart';
import 'package:digital_product/features/services/presentation/widgets/services_silver_body.dart';
import 'package:digital_product/features/services/presentation/widgets/services_silver_toggle.dart';
import 'package:flutter/material.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  final TextEditingController searchController = TextEditingController();

  int selectedIndex = 0;

  String searchQuery = '';

  Timer? _debounce;

  // ================= GENERAL SERVICES =================

  final List<ServiceModel> generalServices = const [
    ServiceModel(
      title: 'التحرير اللغوي',
      description:
          'مراجعة وتحسين الأسلوب اللغوي وإعادة صياغة النصوص بطريقة احترافية.',
      price: '3',
      currency: 'ر.س',
      priceDescription: 'لكل صفحة . دفع بعد',
    ),
    ServiceModel(
      title: 'التدقيق اللغوي',
      description:
          'فحص شامل للنص وتصحيح الأخطاء النحوية والإملائية وضبط الأسلوب.',
      price: '3',
      currency: 'ر.س',
      priceDescription: 'لكل صفحة . دفع بعد',
    ),
    ServiceModel(
      title: 'التدقيق الإملائي',
      description:
          'تصحيح الأخطاء الإملائية والكتابية بدقة عالية في النصوص العربية.',
      price: '3',
      currency: 'ر.س',
      priceDescription: 'لكل صفحة . دفع بعد',
    ),
    ServiceModel(
      title: 'إدخال بيانات',
      description:
          'إدخال وترتيب البيانات النصية بدقة واحترافية ضمن الجداول والقواعد.',
      price: '0.25',
      currency: 'ر.س',
      priceDescription: 'لكل كلمة . دفع مسبق',
    ),
  ];

  // ================= EDUCATIONAL SERVICES =================

  final List<ServiceModel> educationalServices = const [
    ServiceModel(
      title: 'حل الواجبات',
      description: 'المساعدة في حل الواجبات التعليمية بطريقة واضحة ومنظمة.',
      price: '20',
      currency: 'ر.س',
      priceDescription: 'حسب نوع الواجب',
    ),
    ServiceModel(
      title: 'تلخيص الأبحاث',
      description: 'تلخيص الأبحاث والمحتوى الأكاديمي بطريقة واضحة واحترافية.',
      price: '15',
      currency: 'ر.س',
      priceDescription: 'حسب عدد الصفحات',
    ),
  ];

  // ================= ALL SERVICES =================

  List<ServiceModel> get allServices => [
    ...generalServices,
    ...educationalServices,
  ];

  // ================= DISPLAYED SERVICES =================

  List<ServiceModel> get displayedServices {
    final query = searchQuery.trim().toLowerCase();

    // لو فيه Search ابحث في كل الخدمات
    if (query.isNotEmpty) {
      return allServices.where((service) {
        final title = service.title.toLowerCase();
        final description = service.description.toLowerCase();

        return title.contains(query) || description.contains(query);
      }).toList();
    }

    // مفيش Search، اعرض حسب الـ Toggle
    if (selectedIndex == 0) {
      return generalServices;
    }

    return educationalServices;
  }

  // ================= INIT =================

  @override
  void initState() {
    super.initState();

    searchController.addListener(_onSearchChanged);
  }

  // ================= SEARCH =================

  void _onSearchChanged() {
    // إلغاء البحث السابق
    _debounce?.cancel();

    // الانتظار بعد آخر حرف
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      setState(() {
        searchQuery = searchController.text;
      });
    });
  }

  // ================= TOGGLE =================

  void onToggleChanged(int index) {
    if (selectedIndex == index) return;

    setState(() {
      selectedIndex = index;
    });
  }

  // ================= SERVICE PRESSED =================

  void onServicePressed(ServiceModel service) {
    AppShowModelBottomSheet.appShowModalBottomSheet(
      context,
      service,
      Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: ServiceOrderBottomSheet(service: service),
      ),
    );
  }

  // ================= DISPOSE =================

  @override
  void dispose() {
    _debounce?.cancel();

    searchController.removeListener(_onSearchChanged);
    searchController.dispose();

    super.dispose();
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              // ================= APP BAR =================
              ServicesSilverAppbar(searchController: searchController),

              // ================= SERVICES TYPE =================
              ServicesSilverToggle(
                selectedIndex: selectedIndex,
                onToggleChanged: onToggleChanged,
              ),

              // ================= SERVICES =================
              ServicesSliverBody(
                services: displayedServices,
                onServicePressed: onServicePressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
