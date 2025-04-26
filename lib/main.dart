import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notas_riverpod/business/providers/authentication/auth_provider.dart';
import 'package:notas_riverpod/presentation/screens/home_page.dart';
import 'package:notas_riverpod/presentation/screens/login_page.dart';
import 'config/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Necesario para async en main()
  await SupabaseConfig.initialize(); // Inicializa Supabase

  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer(
        builder: (context, ref, child) {
          final userAsync = ref.watch(currentUserProvider);
          return userAsync.when(
            data:
                (user) =>
                    user == null
                        ? LoginPage()
                        : HomePage(email: user.email!.split("@").first),
            error: (error, stackTrace) => LoginPage(),
            loading: () => const CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
