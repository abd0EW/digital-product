import 'dart:async';
import 'package:digital_product/features/dashboard_user/notifications/data/models/notification_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();

  //Future<void> markAsRead({required String notificationId});
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  NotificationRemoteDataSourceImpl({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  @override
  Future<List<NotificationModel>> getNotifications() async {
    final userId = _currentUserId;

    final response = await _client
        .from('notifications')
        .select('''
      *,
      order:orders(
        *,
        service:services(*)
      )
    ''')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return response
        .map(
          (row) => NotificationModel.fromJson(Map<String, dynamic>.from(row)),
        )
        .toList();
  }

  String get _currentUserId {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw const AuthException('User is not authenticated');
    }
    return user.id;
  }
}
