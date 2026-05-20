import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'services/auth.dart';

import 'views/authenticate/login_view.dart';
import 'views/home/home_view.dart';
import 'views/entry/add_promociones_view.dart';


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
        '/': (context) => StreamBuilder(
              stream: AuthService().estadoUsuario,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasData) {
                  return const Home(); // Redirige a tu vista Home original
                }
                return const LoginView();
              },
            ),
            '/add':(context) => const AddPromocionesPage(),
      },
      theme: ThemeData(
        // Corrección del detalle de sintaxis: se agrega 'ColorScheme'
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}