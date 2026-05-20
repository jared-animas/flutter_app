import 'package:flutter/material.dart';
import 'custom_input.dart';
import 'custom_switch.dart';

class PromocionFormTemplate extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController tituloController;
  final TextEditingController descripcionController;
  final TextEditingController fechaController;
  final bool estadoValue;
  final ValueChanged<bool> onEstadoChanged;
  final VoidCallback onFechaTap;

  const PromocionFormTemplate({
    super.key,
    required this.formKey,
    required this.tituloController,
    required this.descripcionController,
    required this.fechaController,
    required this.estadoValue,
    required this.onEstadoChanged,
    required this.onFechaTap,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            CustomInput(
              controller: tituloController,
              label: 'Título',
              keyboardType: TextInputType.text,
            ),
            CustomInput(
              controller: descripcionController,
              label: 'Descripción',
              keyboardType: TextInputType.text,
            ),
            GestureDetector(
              onTap: onFechaTap,
              child: AbsorbPointer(
                child: CustomInput(
                  controller: fechaController,
                  label: 'Fecha',
                  keyboardType: TextInputType.none,
                ),
              ),
            ),
            CustomSwitch(
              title: 'Estado (Activa/Inactiva)',
              value: estadoValue,
              onChanged: onEstadoChanged,
            ),
          ],
        ),
      ),
    );
  }
}
