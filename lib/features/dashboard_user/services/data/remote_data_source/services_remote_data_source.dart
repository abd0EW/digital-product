import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/service_model.dart';

abstract class ServicesRemoteDataSource {
  Future<List<ServiceModel>> getServices();
}

class ServicesRemoteDataSourceImpl implements ServicesRemoteDataSource {
  final SupabaseClient _client;

  ServicesRemoteDataSourceImpl({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  @override
  Future<List<ServiceModel>> getServices() async {
    try {
      final response = await _client
          .from('services')
          .select()
          .eq('is_active', true)
          .order('sort_order', ascending: true);
      print("response ${response}");
      return (response as List)
          .map((row) => ServiceModel.fromJson(Map<String, dynamic>.from(row)))
          .toList();
    } catch (e) {
      print("=============================================");
      print("${e.toString()}");
      rethrow;
    }
  }
}
