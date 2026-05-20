import 'package:flutter/material.dart';
import 'package:flutter_app/views/widgets/custom_form.dart';
import 'package:flutter_app/views/widgets/custom_input.dart';
import 'package:flutter_app/views/widgets/custom_switch.dart';
import '../controllers/auth_controller.dart';
import '../controllers/display_controller.dart';
import '../controllers/update_controller.dart';
import '../models/item_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthController _authController = AuthController();
  final DisplayController _displayController = DisplayController();
  String _filtroSeleccionado = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Lista de Promociones',
          style: TextStyle(color: Color(0xFF101213), fontSize: 28, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () async => await _authController.ejecutarLogout(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Acontinuacion se muestran todas las promociones', style: TextStyle(color: Color(0xFF57636C), fontSize: 14)),
            const SizedBox(height: 16),

            // FILTROS
            Row(
              children: ['All', 'activas', 'inactivas'].map((tipo) {
                final bool esSeleccionado = _filtroSeleccionado == tipo;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(tipo),
                    selected: esSeleccionado,
                    selectedColor: const Color.fromARGB(255, 177, 168, 255),
                    onSelected: (bool selected) {
                      if (selected) setState(() => _filtroSeleccionado = tipo);
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // ENCABEZADO DE LA TABLA
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(color: const Color(0xFFF1F4F8), borderRadius: BorderRadius.circular(8)),
              child: const Row(
                children: [
                  Expanded(flex: 3, child: Text('Titulo', style: TextStyle(color: Color(0xFF57636C), fontWeight: FontWeight.w500))),
                  Expanded(flex: 2, child: Text('Fecha', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF57636C), fontWeight: FontWeight.w500))),
                  Expanded(flex: 1, child: Text('Estado (Activo/Inactivo)', textAlign: TextAlign.justify , style: TextStyle(color: Color(0xFF57636C), fontWeight: FontWeight.w500))),
                  Expanded(flex: 1, child: Text('Editar', textAlign: TextAlign.right, style: TextStyle(color: Color(0xFF57636C), fontWeight: FontWeight.w500))),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // LISTADO EN TIEMPO REAL
            Expanded(
              child: StreamBuilder<List<PromocionModel>>(
                stream: _displayController.streamPromociones,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No hay registros disponibles.'));
                  }

                  final listaFiltrada = snapshot.data!.where((promo) {
                    if (_filtroSeleccionado == 'activas') return promo.estado == true;
                    if (_filtroSeleccionado == 'inactivas') return promo.estado == false;
                    return true;
                  }).toList();

                  return ListView.builder(
                    itemCount: listaFiltrada.length,
                    itemBuilder: (context, index) {
                      final promo = listaFiltrada[index];

                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Color(0xFFF1F4F8))),
                        ),
                        child: Row(
                          children: [
                            Expanded(flex: 3, child: Text(promo.titulo, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                            Expanded(flex: 2, child: Text(promo.fecha.toString().substring(0, 10), textAlign: TextAlign.center)),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.center,
                                child: Switch(
                                  value: promo.estado,
                                  // CAMBIO DE COLORES DINÁMICOS (Verde / Rojo)
                                  activeThumbColor: const Color.fromARGB(255, 0, 0, 0),
                                  activeTrackColor: const Color.fromARGB(255, 0, 255, 8).withValues(alpha: 0.3),
                                  inactiveThumbColor: const Color.fromARGB(59, 0, 0, 0),
                                  inactiveTrackColor: const Color.fromARGB(255, 255, 17, 0).withValues(alpha: 0.3),
                                  onChanged: null,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: const Icon(Icons.edit, color: Color(0xFF4B39EF)),
                                  onPressed: () => _mostrarDialogoEdicion(context, promo),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4B39EF),
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}


// ventanita de edición
void _mostrarDialogoEdicion(BuildContext context, PromocionModel promo) {
  // Precargamos los controladores locales con los datos actuales del elemento seleccionado
  final TextEditingController tituloEditController = TextEditingController(text: promo.titulo);
  final TextEditingController descripcionEditController = TextEditingController(text: promo.descripcion);
  final UpdateController _upateController = UpdateController();
  DateTime fechaEdit = promo.fecha;
  bool estadoEdit = promo.estado;

  final TextEditingController fechaEditController = TextEditingController(
    text: "${promo.fecha.year}-${promo.fecha.month.toString().padLeft(2, '0')}-${promo.fecha.day.toString().padLeft(2, '0')}"
  );

  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text(
              'Modificar Registro',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            content: PromocionFormTemplate(
              formKey: formKey,
              tituloController: tituloEditController,
              descripcionController: descripcionEditController,
              fechaController: fechaEditController,
              estadoValue: estadoEdit,
              onEstadoChanged: (val) {
                setDialogState(() => estadoEdit = val);
              },
              onFechaTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: fechaEdit,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  setDialogState(() {
                    fechaEdit = picked;
                    fechaEditController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                  });
                }
              },
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              // Botón Cancelar
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
              ),
              // Botón Guardar Cambios
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B39EF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () async {
                  String? error = await _upateController.modificarPromocion(
                    id: promo.id,
                    titulo: tituloEditController.text,
                    descripcion: descripcionEditController.text,
                    fecha: fechaEdit,
                    estado: estadoEdit,
                  );

                  if (error != null && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error), backgroundColor: Colors.red),
                    );
                  } else if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('¡Actualizado con éxito!'), backgroundColor: Colors.green),
                    );
                    Navigator.pop(context); // Cierra la ventana emergente automáticamente
                  }
                },
                child: const Text('Guardar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      );
    },
  );
}
