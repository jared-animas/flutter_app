import 'package:flutter/material.dart';
import 'package:flutter_app/views/widgets/custom_input.dart';
import '../../controllers/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController _authController = AuthController();
  
  final TextEditingController _emailInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();
  
  bool _cargando = false;

  void _ejecutarLogin() async {
    setState(() => _cargando = true);

    // Mandamos los datos al controlador y esperamos la respuesta
    String? error = await _authController.intentarLogin(
      email: _emailInput.text,
      password: _passwordInput.text,
    );

    setState(() => _cargando = false);

    if (error != null) {
      // Si el controlador regresa un mensaje, lo mostramos
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: Colors.red),
      );
    } else {
      // Si fue exitoso, Firebase cambia el estado de la app automáticamente
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Bienvenido!'), backgroundColor: Colors.green),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8), 
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
        backgroundColor: const Color(0xFFF1F4F8),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // APLICAR EL COMPONENTE PARA EL EMAIL
            CustomInput(
              controller: _emailInput,
              label: 'Correo Electrónico',
              keyboardType: TextInputType.emailAddress,
            ),
            
            // REUTILIZAR EL COMPONENTE PARA LA CONTRASEÑA
            CustomInput(
              controller: _passwordInput,
              label: 'Contraseña',
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),

            const SizedBox(height: 16),
            _cargando
                ? const CircularProgressIndicator(color: Color(0xFF4B39EF))
                : SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _ejecutarLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4B39EF),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: const Text(
                        'Ingresar',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}