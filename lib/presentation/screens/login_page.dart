import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notas_riverpod/business/providers/authentication/auth_provider.dart';
import 'package:notas_riverpod/presentation/screens/register_page.dart';
import 'package:notas_riverpod/presentation/widgets/custom_button.dart';
import 'package:notas_riverpod/presentation/widgets/custom_textfield.dart';

class LoginPage extends ConsumerWidget {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Icono
              Icon(Icons.note, color: Colors.yellow, size: 50),
              SizedBox(height: 10),

              //Usuario
              CustomTextfield(controller: userController, hint: "Usuario"),
              SizedBox(height: 10),
              //Contrasena
              CustomTextfield(
                controller: passwordController,
                hint: "Contraseña",
                isObscured: true,
              ),
              SizedBox(height: 10),
              //Crea una cuenta
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("No tienes una cuenta?"),
                  SizedBox(width: 5),
                  GestureDetector(
                    child: const Text(
                      "Crea una nueva.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                  ),
                ],
              ),
              //Boton iniciar sesion
              SizedBox(height: 10),
              CustomButton(
                text: "Iniciar sesion",
                ontap: authState.isLoading ? null : () => _login(ref),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login(WidgetRef ref) {
    ref
        .read(authProvider.notifier)
        .login(userController.text, passwordController.text);
  }
}
