
import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../controllers/auth_controller.dart';
import '../models/item_model.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthController authController = AuthController();
  final FirebaseService _firebaseService = FirebaseService();
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter + Firebase'),
        // Desplegable para cierre de sesion
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (value) async {
              if (value == 'logout') {

                bool exito = await authController.ejecutarLogout();
                if (!exito && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No se pudo cerrar la sesión')),
                  );
                }
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red, size: 20),
                    SizedBox(width: 10),
                    Text(
                      'Cerrar Sesión',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: FutureBuilder<List<PromocionModel>>(
          future: _firebaseService.getPromociones(),
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final listaPromociones = snapshot.data!;

              return ListView.builder(
                itemCount: listaPromociones.length,
                itemBuilder: (context, index) {
                  final promocion = listaPromociones[index];
                  return Text(promocion.titulo);
                },
              );
            } else {
              return const Center(
                child: Text('No hay promociones disponibles.'),
              );
            }
          },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),),
    );
  }
}
