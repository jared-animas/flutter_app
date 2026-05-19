import 'package:flutter/material.dart';

import '../../controllers/entry_controller.dart';
import '../views/widgets/custom_input.dart';
import '../views/widgets/custom_switch.dart';

class AddPromocionesPage extends StatefulWidget{
  const AddPromocionesPage({super.key});

  @override
  State<AddPromocionesPage> createState() => _AddPromocionPageState();
  }

class _AddPromocionPageState extends State<AddPromocionesPage> {
  final EntryController _entryController = EntryController();

  TextEditingController tituloEditingController = TextEditingController();
  TextEditingController descripcionEditingController = TextEditingController();
  TextEditingController fechaEditingController = TextEditingController();
  TextEditingController estadoEditingController = TextEditingController();

  DateTime _fechaSeleccionada = DateTime.now();
  bool _estadoSeleccionado = false;
  bool _cargando = false;

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
        const SnackBar(content: Text('¡Guardado con éxito!'), backgroundColor: Colors.green),
      );

      Navigator.pop(context, true);
    }
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8), // Fondo gris claro consistente
      appBar: AppBar(
        title: const Text('Nueva promocion'),
        backgroundColor: const Color(0xFFF1F4F8),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            // Envolvemos tus inputs en la tarjeta centrada de 450px que querías
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

                  CustomInput(
                    controller: tituloEditingController,
                    label: 'Titulo de la promocion',
                    keyboardType: TextInputType.text,
                  ),
                  CustomInput(
                    controller: descripcionEditingController,
                    label: 'Descripcion de la promocion',
                    keyboardType: TextInputType.text,
                  ),
                  InputDatePickerFormField(
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                    initialDate: _fechaSeleccionada,
                    fieldLabelText: 'Fecha de la promoción',
                    onDateSubmitted: (date) {
                      _fechaSeleccionada = date;
                    },
                    onDateSaved: (date) {
                      _fechaSeleccionada = date;
                    },
                  ),
                  CustomSwitch(
                    title: 'Estado de la promoción (Inactivo/Activo)',
                    value: _estadoSeleccionado,
                    onChanged: (bool nuevoValor) {
                      setState(() {
                        _estadoSeleccionado = nuevoValor;
                      });
                    },
                  ),
                  const SizedBox(height: 24),

                  _cargando
                      ? const CircularProgressIndicator(color: Color(0xFF4B39EF))
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
                            child: const Text('Guardar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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




