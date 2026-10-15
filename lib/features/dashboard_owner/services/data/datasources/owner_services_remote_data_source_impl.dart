import 'package:digital_product/features/dashboard_owner/services/data/datasources/owner_services_remote_data_source.dart';
import 'package:digital_product/features/dashboard_owner/services/data/models/owner_service_model.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OwnerServicesRemoteDataSourceImpl
    implements OwnerServicesRemoteDataSource {
  final SupabaseClient _client;

  OwnerServicesRemoteDataSourceImpl({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;
  @override
  Future<List<ServiceModel>> getServices() async {
    try {
      final response = await _client
          .from('services')
          .select()
          .order('sort_order', ascending: true);

      return response.map((e) => ServiceModel.fromJson(e)).toList();
    } catch (e) {
      print("**************");
      print(e);
      rethrow;
    }
  }

  @override
  Future<void> updateServiceActive({
    required String serviceId,
    required bool isActive,
  }) async {
    await _client
        .from('services')
        .update({'is_active': isActive})
        .eq('id', serviceId)
        .select('id')
        .single();
  }
}
