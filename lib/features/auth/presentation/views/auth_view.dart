// import 'package:digital_product/features/auth/presentation/views/login_view.dart';
// import 'package:digital_product/features/auth/presentation/views/register_view.dart';
// import 'package:flutter/material.dart';

// class AuthView extends StatefulWidget {
//   const AuthView({super.key});

//   @override
//   State<AuthView> createState() => _AuthViewState();
// }

// class _AuthViewState extends State<AuthView> {
//   bool _showLogin = true;

//   void _showRegister() {
//     setState(() {
//       _showLogin = false;
//     });
//   }

//   void _showLoginView() {
//     setState(() {
//       _showLogin = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return IndexedStack(
//       index: _showLogin ? 0 : 1,
//       children: [
//         LoginView(
//           onRegisterPressed: _showRegister,
//         ),
//         RegisterView(
//           onLoginPressed: _showLoginView,
//         ),
//       ],
//     );
//   }
// }
