import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:transit_tracer/features/auth/auth_repository/abstract_auth_repository.dart';
import 'package:transit_tracer/app/router/router.dart';

@RoutePage(name: 'AuthGateRoute')
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: GetIt.I<AbstractAuthRepository>().authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return AutoRouter.declarative(
          routes: (_) => [
            if (user == null) const AuthRoute() else const HomeRoute(),
          ],
        );
      },
    );
  }
}
