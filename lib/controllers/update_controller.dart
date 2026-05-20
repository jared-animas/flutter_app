import '../models/item_model.dart';
import '../services/firebase_service.dart';

class UpdateController {
  final FirebaseService _firebaseService = FirebaseService();

  // Valida y ejecuta la edición
  Future<String?> modificarPromocion({
    required String? id,
    required String titulo,
    required String descripcion,
    required DateTime fecha,
    required bool estado,
  }) async {
    try {
      if (id == null || id.isEmpty) return 'Error: El ID de la promocion es requerido.';
      if (titulo.trim().isEmpty || descripcion.trim().isEmpty) return 'Campos vacios.';

      final promocionEditada = PromocionModel(
        id: id,
        titulo: titulo.trim(),
        descripcion: descripcion.trim(),
        fecha: fecha,
        estado: estado,
      );

      await _firebaseService.actualizarPromocion(id, promocionEditada);
      return null; // Éxito
    } catch (e) {
      return 'Error al actualizar: $e';
    }
  }
}