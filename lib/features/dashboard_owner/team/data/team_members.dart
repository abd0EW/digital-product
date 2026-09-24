import 'package:digital_product/features/dashboard_owner/team/data/models/team_member_model.dart';

const List<TeamMemberModel> teamMembers = [
  TeamMemberModel(
    name: 'محمد العمري',
    email: 'owner@platform.sa',
    role: 'مالك',
    initial: 'م',
    isOwner: true,
  ),
  TeamMemberModel(
    name: 'عبدالله السلام',
    email: 'abdullah@platform.sa',
    role: 'مساعد',
    initial: 'ع',
    activeOrders: 5,
  ),
  TeamMemberModel(
    name: 'نورة القحطاني',
    email: 'noura@platform.sa',
    role: 'مساعد',
    initial: 'ن',
    activeOrders: 7,
  ),
];
