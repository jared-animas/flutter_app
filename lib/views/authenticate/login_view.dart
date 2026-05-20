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
  final TextEditingController _emailRegisterInput = TextEditingController();
  final TextEditingController _passwordRegisterInput = TextEditingController();
  final TextEditingController _passwordConfirmRegisterInput =
      TextEditingController();

  bool _cargando = false;

  // llamada al controlador de login
  void _ejecutarLogin() async {
    setState(() => _cargando = true);

    String? error = await _authController.intentarLogin(
      email: _emailInput.text,
      password: _passwordInput.text,
    );

    setState(() => _cargando = false);

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: Colors.red),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Bienvenido!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  // llamada al controlador de registro
  void _ejecutarRegistro() async {
    setState(() => _cargando = true);

    String? error = await _authController.intentarRegistro(
      email: _emailRegisterInput.text,
      password: _passwordRegisterInput.text,
    );

    setState(() => _cargando = false);

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: Colors.red),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Bienvenido!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 155, 83, 161),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 450),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TabBar(
                      indicatorColor: Color(0xFF4B39EF),
                      labelColor: Color(0xFF4B39EF),
                      unselectedLabelColor: Color(0xFF57636C),
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(text: 'Iniciar Sesión'),
                        Tab(text: 'Registrarse'),
                      ],
                    ),
                    SizedBox(
                      height: 340,
                      child: TabBarView(
                        children: [
                          // Formulario Iniciar Sesión
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomInput(
                                  controller: _emailInput,
                                  label: 'Correo Electrónico',
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                CustomInput(
                                  controller: _passwordInput,
                                  label: 'Contraseña',
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                ),
                                const SizedBox(height: 16),
                                _cargando
                                    ? const CircularProgressIndicator(
                                        color: Color(0xFF4B39EF),
                                      )
                                    : SizedBox(
                                        width: double.infinity,
                                        height: 56,
                                        child: ElevatedButton(
                                          onPressed: _ejecutarLogin,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFF4B39EF,
                                            ),
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                          ),
                                          child: const Text(
                                            'Ingresar',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),

                          // Formulario Registro
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomInput(
                                  controller: _emailRegisterInput,
                                  label: 'Correo Electrónico',
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                CustomInput(
                                  controller: _passwordRegisterInput,
                                  label: 'Contraseña',
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                ),
                                CustomInput(
                                  controller: _passwordConfirmRegisterInput,
                                  label: 'Confirma tu Contraseña',
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                ),
                                // const SizedBox(height: 8),
                                _cargando
                                    ? const CircularProgressIndicator(
                                        color: Color(0xFF4B39EF),
                                      )
                                    : SizedBox(
                                        width: double.infinity,
                                        height: 56,
                                        child: ElevatedButton(
                                          onPressed: _ejecutarRegistro,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFF4B39EF,
                                            ),
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                          ),
                                          child: const Text(
                                            'Crear Cuenta',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
