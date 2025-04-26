import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notas_riverpod/business/providers/authentication/auth_provider.dart';
import 'package:notas_riverpod/presentation/widgets/custom_button.dart';
import 'package:notas_riverpod/presentation/widgets/custom_textfield.dart';

class RegisterPage extends ConsumerWidget {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  RegisterPage({super.key});

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
              //Confirmar contrasena
              CustomTextfield(
                controller: confirmPasswordController,
                hint: "Confirmar contraseña",
                isObscured: true,
              ),
              SizedBox(height: 10),
              //Crea una cuenta
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Ya tienes una cuenta?"),
                  SizedBox(width: 5),
                  GestureDetector(
                    child: const Text(
                      "Inicia sesion.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              //Boton iniciar sesion
              SizedBox(height: 10),
              CustomButton(
                text: "Crear cuenta",
                ontap: authState.isLoading ? null : () => _signUp(ref),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp(WidgetRef ref) {
    if (passwordController.text != confirmPasswordController.text) {
      return;
    }
    ref
        .read(authProvider.notifier)
        .signUp(userController.text, passwordController.text);
  }
}
