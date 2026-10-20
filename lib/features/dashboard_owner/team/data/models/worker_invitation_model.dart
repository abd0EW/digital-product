class WorkerInvitationModel {
  const WorkerInvitationModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.invitedBy,
    required this.status,
    this.acceptedUserId,
    this.createdAt,
  });

  final String? id;
  final String fullName;
  final String email;
  final String invitedBy;
  final String status;
  final String? acceptedUserId;
  final DateTime? createdAt;

  factory WorkerInvitationModel.fromJson(Map<String, dynamic> json) {
    return WorkerInvitationModel(
      id: json['id'] as String?,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      invitedBy: json['invited_by'] as String,
      status: json['status'] as String,
      acceptedUserId: json['accepted_user_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'full_name': fullName,
      'email': email,
      'invited_by': invitedBy,
      'status': status,
      'accepted_user_id': acceptedUserId,
    };

    if (id != null) json['id'] = id;
    if (createdAt != null) {
      json['created_at'] = createdAt!.toIso8601String();
    }

    return json;
  }
}
