import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notas_riverpod/business/providers/authentication/auth_provider.dart';
import 'package:notas_riverpod/presentation/screens/login_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Bienvenido a homepage"), centerTitle: true),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(authProvider.notifier).signOut();
          },
          child: Text("Cerrar sesion"),
        ),
      ),
    );
  }
}
