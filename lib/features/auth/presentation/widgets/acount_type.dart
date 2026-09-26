import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/features/auth/presentation/widgets/acount_type_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum AcountType { user, owner, worker }

class AccountTypeSelector extends StatelessWidget {
  const AccountTypeSelector({
    super.key,
    required this.valueListenable,
    required this.onChanged,
  });

  final ValueListenable<AcountType> valueListenable;
  final ValueChanged<AcountType> onChanged;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AcountType>(
      valueListenable: valueListenable,
      builder: (context, value, child) {
        return Row(
          spacing: AppSpacing.xs,
          children: [
            Expanded(
              child: AccountTypeItem(
                title: 'عميل',
                icon: Icons.person,
                isSelected: value == AcountType.user,
                onTap: () {
                  onChanged(AcountType.user);
                },
              ),
            ),

            Expanded(
              child: AccountTypeItem(
                title: 'مزود خدمة',
                icon: Icons.business_outlined,
                isSelected: value == AcountType.owner,
                onTap: () {
                  onChanged(AcountType.owner);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
