import 'package:digital_product/core/widgets/app_fail_state_silver.dart';
import 'package:digital_product/core/widgets/app_state_loading_silver.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/get_order_file_success_silver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';

import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order_files/get_order_files_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order_files/get_order_files_state.dart';

class OrderAttachmentCard extends StatefulWidget {
  const OrderAttachmentCard({super.key});

  @override
  State<OrderAttachmentCard> createState() => _OrderAttachmentCardState();
}

class _OrderAttachmentCardState extends State<OrderAttachmentCard> {
  String? _openingFilePath;

  Future<void> _openOrderFile(String storagePath) async {
    if (_openingFilePath != null) return;

    setState(() {
      _openingFilePath = storagePath;
    });

    try {
      final signedUrl = await context.read<GetOrderFilesCubit>().getFileUrl(
        storagePath: storagePath,
      );

      if (!mounted) return;

      if (signedUrl == null || signedUrl.isEmpty) {
        throw Exception('تعذر إنشاء رابط للملف');
      }

      final uri = Uri.tryParse(signedUrl);

      if (uri == null ||
          !uri.hasAuthority ||
          (uri.scheme != 'https' && uri.scheme != 'http')) {
        throw Exception('رابط الملف غير صالح');
      }

      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);

      if (!opened) {
        throw Exception('تعذر فتح الملف');
      }
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر فتح الملف. حاول مرة أخرى.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _openingFilePath = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOrderFilesCubit, GetOrderFilesState>(
      builder: (context, state) {
        if (state is GetOrderFilesLoading || state is GetOrderFilesInitial) {
          return const AppStateLoadingSilver();
        }

        if (state is GetOrderFilesEmpty) {
          return const SizedBox.shrink();
        }

        if (state is GetOrderFilesFailure) {
          return const AppFailStateSilver(failureMessage: "failureMessage");
        }

        if (state is GetOrderFilesSuccess) {
          if (state.files.isEmpty) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }
          return GetOrderFileSuccessSilver(
            files: state.files,
            onOpenFile: _openOrderFile,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
