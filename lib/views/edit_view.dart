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
            content: SingleChildScrollView(
              child: Form(
                key: formKey,
              child: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    CustomInput(
                      controller: tituloEditController,
                      label: 'Título',
                      keyboardType: TextInputType.text,
                    ),
                    CustomInput(
                      controller: descripcionEditController,
                      label: 'Descripción',
                      keyboardType: TextInputType.text,
                    ),
                    GestureDetector(
                      onTap: () async {
                        // Desplegamos el calendario nativo al tocar la caja de texto
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: fechaEdit,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (picked != null) {
                          // Modificamos el estado interno del diálogo flotante
                          setDialogState(() {
                            fechaEdit = picked;
                            // Pintamos el resultado directamente dentro de la caja de texto
                            fechaEditController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: CustomInput(
                          controller: fechaEditController,
                          label: 'Fecha de Expiración',
                          keyboardType: TextInputType.none, // Bloquea el teclado del celular
                        ),
                      ),
                    ),
                    CustomSwitch(
                      title: 'Estado (Activa/Inactiva)',
                      value: estadoEdit,
                      onChanged: (val) {
                        setDialogState(() => estadoEdit = val);
                      },
                    ),
                  ],
                ),
              ),
            ),
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
