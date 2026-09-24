class TeamMemberModel {
  const TeamMemberModel({
    required this.name,
    required this.email,
    required this.role,
    required this.initial,
    this.activeOrders = 0,
    this.isOwner = false,
  });

  final String name;
  final String email;
  final String role;
  final String initial;
  final int activeOrders;
  final bool isOwner;
}
