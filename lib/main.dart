import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'services/auth.dart';
import 'views/authenticate/login_view.dart';
import 'views/home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp((const MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter + Firebase',
      debugShowCheckedModeBanner: false, // Quita la pestaña roja de debug
      initialRoute: '/',
      routes: {
        // La ruta raíz ahora decide inteligentemente qué pantalla mostrar
        '/': (context) => StreamBuilder(
              stream: AuthService().estadoUsuario, // Escucha el estado de Firebase Auth
              builder: (context, snapshot) {
                // Mientras Firebase responde, muestra una pantalla de carga blanca
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
                
                // Si el snapshot tiene datos, significa que el usuario está logueado
                if (snapshot.hasData) {
                  return const Home(); // Redirige a tu vista Home original
                }
                
                // Si no hay datos, el usuario no está logueado o cerró sesión
                return const LoginView();
              },
            ),
        
        // Descomenta y adapta esta línea cuando crees tu vista de agregar
        // '/add': (context) => const AddPromocionesPage(),
      },
      theme: ThemeData(
        // Corrección del detalle de sintaxis: se agrega 'ColorScheme'
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}