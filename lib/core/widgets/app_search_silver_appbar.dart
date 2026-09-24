import 'package:digital_product/core/widgets/app_header_view.dart';
import 'package:digital_product/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class AppSearchSilverAppbar extends StatelessWidget {
  const AppSearchSilverAppbar({
    super.key,
    required this.searchController,
    required this.textHedader,
    this.onChanged,
  });
  final TextEditingController searchController;
  final String textHedader;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 12,
      title: AppHeaderView(textHedader: textHedader),

      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 4, 16, 12),
              child: AppTextField(
                onChanged: onChanged,
                controller: searchController,
                hintText: 'ابحث عن خدمة...',
              ),
            );
          },
        ),
      ),
    );
  }
}
