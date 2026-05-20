import 'package:flutter/material.dart';
import 'package:flutter_app/views/widgets/custom_form.dart';
import 'package:flutter_app/views/widgets/custom_popup.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/promocion_controller.dart';
import '../../models/item_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthController _authController = AuthController();
  final PromocionController _displayController = PromocionController();
  String _filtroSeleccionado = 'All';

  @override
  Widget build(BuildContext context) {
    //ajustar tamaño de elementos
    final double anchoPantalla = MediaQuery.of(context).size.width;
    final bool mostrarColumnasExtra = anchoPantalla > 600;
    final double tamanoTitulo = (anchoPantalla * 0.025).clamp(20.0, 32.0);
    final double tamanoSubtitulo = (anchoPantalla * 0.012).clamp(12.0, 15.0);
    final double tamanoTabla = (anchoPantalla * 0.013).clamp(13.0, 16.0);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(179, 194, 147, 212),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Lista de Promociones',
          style: TextStyle(
            color: Color(0xFF101213),
            fontSize: tamanoTitulo,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Menu despllegable para cerrar sesion
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (value) async {
              if (value == 'logout') {
                bool exito = await _authController.ejecutarLogout();
                if (!exito && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No se pudo cerrar la sesión'),
                    ),
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
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool esPantallaGrande = constraints.maxWidth > 768;

          return Center(
            child: Container(
              // ajuste para pc
              constraints: BoxConstraints(
                maxWidth: esPantallaGrande ? 1024 : double.infinity,
              ),
              margin: EdgeInsets.all(esPantallaGrande ? 24.0 : 0.0),
              padding: EdgeInsets.all(esPantallaGrande ? 24.0 : 0.0),
              decoration: BoxDecoration(
                color: esPantallaGrande ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: esPantallaGrande
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Acontinuacion se muestran todas las promociones',
                    style: TextStyle(
                      color: Color(0xFF57636C),
                      fontSize: tamanoSubtitulo,
                    ),
                  ),
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
                          selectedColor: const Color.fromARGB(
                            255,
                            177,
                            168,
                            255,
                          ),
                          onSelected: (bool selected) {
                            if (selected) {
                              setState(() => _filtroSeleccionado = tipo);
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Encabezado de la tabla
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F4F8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Titulo',
                            style: TextStyle(
                              color: Color(0xFF57636C),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (mostrarColumnasExtra)
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Fecha',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF57636C),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Estatus',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Color(0xFF57636C),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Estado actual',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Color(0xFF57636C),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Editar o enviar',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF57636C),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // Expanded(flex: 1, child: Text('Enviar', textAlign: TextAlign.right, style: TextStyle(color: Color(0xFF57636C), fontWeight: FontWeight.w500))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Tomar la lista de promociones y mostrarlas
                  Expanded(
                    child: StreamBuilder<List<PromocionModel>>(
                      stream: _displayController.streamPromociones,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('No hay registros disponibles.'),
                          );
                        }

                        // Funcion para filtrar
                        final listaFiltrada = snapshot.data!.where((promo) {
                          if (_filtroSeleccionado == 'activas') {
                            return promo.estado == true;
                          }
                          if (_filtroSeleccionado == 'inactivas') {
                            return promo.estado == false;
                          }
                          return true;
                        }).toList();

                        return ListView.builder(
                          itemCount: listaFiltrada.length,
                          itemBuilder: (context, index) {
                            final promo = listaFiltrada[index];

                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Color(0xFFF1F4F8)),
                                ),
                              ),
                              //elementos de la tabla
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      promo.titulo,
                                      style: TextStyle(
                                        fontSize: tamanoTabla,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  if (mostrarColumnasExtra)
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        promo.fecha.toString().substring(0, 10),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  Expanded(
                                    child: Switch(
                                      value: promo.estado,
                                      // CAMBIO DE COLORES DINÁMICOS (Verde / Rojo)
                                      activeThumbColor: const Color.fromARGB(
                                        255,
                                        0,
                                        0,
                                        0,
                                      ),
                                      activeTrackColor: const Color.fromARGB(
                                        255,
                                        0,
                                        255,
                                        8,
                                      ).withValues(alpha: 0.3),
                                      inactiveThumbColor: const Color.fromARGB(
                                        59,
                                        0,
                                        0,
                                        0,
                                      ),
                                      inactiveTrackColor: const Color.fromARGB(
                                        255,
                                        255,
                                        17,
                                        0,
                                      ).withValues(alpha: 0.3),
                                      onChanged: null,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: promo.fechaEnvio != null
                                            ? const Text(
                                                'Enviada',
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            : const Text(
                                                'Pendiente',
                                                style: TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: PromocionMenuOptions(
                                        promo:
                                            promo,
                                        onEditarTap:
                                            (context, promocionSeleccionada) {
                                              _mostrarDialogoEdicion(
                                                context,
                                                promocionSeleccionada,
                                              );
                                            },
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
          );
        },
      ),
      // Botón de creacion de promociones
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4B39EF),
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// Ventanita de edición
void _mostrarDialogoEdicion(BuildContext context, PromocionModel promo) {
  final TextEditingController tituloEditController = TextEditingController(
    text: promo.titulo,
  );
  final TextEditingController descripcionEditController = TextEditingController(
    text: promo.descripcion,
  );
  final PromocionController upateController = PromocionController();
  final PromocionController deleteController = PromocionController();

  DateTime fechaEdit = promo.fecha;
  bool estadoEdit = promo.estado;

  // Formateo de fecha
  final TextEditingController fechaEditController = TextEditingController(
    text:
        "${promo.fecha.year}-${promo.fecha.month.toString().padLeft(2, '0')}-${promo.fecha.day.toString().padLeft(2, '0')}",
  );

  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
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
                    fechaEditController.text =
                        "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                  });
                }
              },
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Botón Cancelar
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(111, 170, 170, 170),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(141, 248, 55, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      String? error = await deleteController.eliminarPromocion(
                        id: promo.id,
                      );

                      if (error != null && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(error),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('¡Eliminado con éxito!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(
                          context,
                        ); // Cierra la ventana emergente automáticamente
                      }
                    },
                    child: const Text(
                      'Borrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Botón Guardar Cambios
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4B39EF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      String? error = await upateController.modificarPromocion(
                        id: promo.id,
                        titulo: tituloEditController.text,
                        descripcion: descripcionEditController.text,
                        fecha: fechaEdit,
                        estado: estadoEdit,
                      );

                      if (error != null && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(error),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('¡Actualizado con éxito!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        // Cierra ventana en automatico
                        Navigator.pop(
                          context,
                        );
                      }
                    },
                    child: const Text(
                      'Guardar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );
}
