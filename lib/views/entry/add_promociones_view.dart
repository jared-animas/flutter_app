import 'package:flutter/material.dart';

import '../../controllers/promocion_controller.dart';
import '../widgets/custom_form.dart';

class AddPromocionesPage extends StatefulWidget {
  const AddPromocionesPage({super.key});

  @override
  State<AddPromocionesPage> createState() => _AddPromocionPageState();
}

class _AddPromocionPageState extends State<AddPromocionesPage> {
  final PromocionController _entryController = PromocionController();

  TextEditingController tituloEditingController = TextEditingController();
  TextEditingController descripcionEditingController = TextEditingController();
  TextEditingController fechaEditingController = TextEditingController();

  DateTime _fechaSeleccionada = DateTime.now();
  bool _estadoSeleccionado = false;
  bool _cargando = false;
  final formKey = GlobalKey<FormState>();

  // precargar el controlador con la fecha actual
  @override
  void initState() {
    super.initState();
    fechaEditingController.text =
        "${_fechaSeleccionada.year}-${_fechaSeleccionada.month.toString().padLeft(2, '0')}-${_fechaSeleccionada.day.toString().padLeft(2, '0')}";
  }

  // Función para manejar el evento de guardar
  void _intentarGuardar() async {
    setState(() => _cargando = true);

    String? error = await _entryController.registrarNuevaPromocion(
      titulo: tituloEditingController.text,
      descripcion: descripcionEditingController.text,
      fecha: _fechaSeleccionada,
      estado: _estadoSeleccionado,
    );

    setState(() => _cargando = false);

    if (error != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: Colors.red),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Guardado con éxito!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8), // Fondo gris claro consistente
      appBar: AppBar(
        title: const Text('Nueva promocion'),
        backgroundColor: const Color.fromARGB(179, 194, 147, 212),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),

            child: Container(
              constraints: const BoxConstraints(maxWidth: 450),
              padding: const EdgeInsets.all(24.0),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Registrar Promoción',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  // Template de formulario
                  PromocionFormTemplate(
                    formKey: formKey,
                    tituloController: tituloEditingController,
                    descripcionController: descripcionEditingController,
                    fechaController: fechaEditingController,
                    estadoValue: _estadoSeleccionado,
                    onEstadoChanged: (bool nuevoValor) {
                      setState(() {
                        _estadoSeleccionado = nuevoValor;
                      });
                    },

                    // Función para manejar el evento de seleccionar la fecha
                    onFechaTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _fechaSeleccionada,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setState(() {
                          _fechaSeleccionada = picked;
                          fechaEditingController.text =
                              "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 24),

                  // Botón de guardar
                  _cargando
                      ? const CircularProgressIndicator(
                          color: Color(0xFF4B39EF),
                        )
                      : SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _intentarGuardar,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4B39EF),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            child: const Text(
                              'Guardar',
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
          ),
        ),
      ),
    );
  }
}
