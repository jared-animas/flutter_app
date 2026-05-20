import 'package:flutter/material.dart';
import '../../models/item_model.dart';
import '../../controllers/send_controller.dart';

class PromocionMenuOptions extends StatelessWidget {
  final PromocionModel promo;
  final Function(BuildContext, PromocionModel) onEditarTap;

  const PromocionMenuOptions({
    super.key,
    required this.promo,
    required this.onEditarTap,
  });

  @override
  Widget build(BuildContext context) {
    final SendController sendController = SendController();

    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Color(0xFF57636C)),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) async {
        if (value == 'editar') {
          // Despliega el formulario de edición
          onEditarTap(context, promo);
        } else if (value == 'enviar') {
          // llamada al controlador de envíos
          String? error = await sendController.registrarEnvio(promo.id);
          if (error != null && context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(error)));
          } else if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('¡Promoción enviada con éxito (Simulación)!'),
                backgroundColor: Colors.blue,
              ),
            );
          }
        }
      },
      itemBuilder: (BuildContext context) => [
        // Edicion
        const PopupMenuItem<String>(
          value: 'editar',
          child: Row(
            children: [
              Icon(Icons.edit, color: Color(0xFF4B39EF), size: 20),
              SizedBox(width: 10),
              Text(
                'Editar',
                style: TextStyle(
                  color: Color(0xFF101213),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // Enviar
        PopupMenuItem<String>(
          value: 'enviar',
          enabled: promo.estado && promo.fechaEnvio == null,
          child: Row(
            children: [
              Icon(
                Icons.send,
                color: (promo.estado && promo.fechaEnvio == null)
                    ? Colors.blue
                    : Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                'Enviar',
                style: TextStyle(
                  color: (promo.estado && promo.fechaEnvio == null)
                      ? const Color(0xFF101213)
                      : Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
