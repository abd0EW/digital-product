enum NotificationUiType { inProgress, payment, completed, welcome }

class NotificationUiModel {
  const NotificationUiModel({
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    required this.isRead,
  });

  final String title;
  final String description;
  final String time;
  final NotificationUiType type;
  final bool isRead;
}
