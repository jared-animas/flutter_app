
import '../models/item_model.dart';
import '../services/firebase_service.dart';

class EntryController {
  final FirebaseService _firebaseService = FirebaseService();

  // Función que llamará tu formulario visual
  Future<String?> registrarNuevaPromocion({
    required String titulo,
    required String descripcion,
    required bool estado,
    required DateTime fecha,
  }) async {
    try {
      // 1. Reglas de negocio (Validación)
      if (titulo.trim().isEmpty || descripcion.trim().isEmpty) {
        return 'Por favor, completa todos los campos.';
      }

      // 2. Creamos la instancia de TU Modelo
      final nuevaPromocion = PromocionModel(
        titulo: titulo.trim(),
        descripcion: descripcion.trim(),
        fecha: DateTime.now(), // Asignamos la fecha actual automáticamente
        estado: estado,
      );

      // 3. Le pasamos el modelo a TU Servicio
      await _firebaseService.addPromocion(nuevaPromocion);
      return null; // Éxito (sin errores)
    } catch (e) {
      return 'Error al registrar la promoción: $e';
    }
  }
}
