
import '../models/item_model.dart';
import '../services/firebase_service.dart';

class EntryController {
  final FirebaseService _firebaseService = FirebaseService();

  Future<String?> registrarNuevaPromocion({
    required String titulo,
    required String descripcion,
    required bool estado,
    required DateTime fecha,
  }) async {
    try {
      // Validaciones
      if (titulo.trim().isEmpty || descripcion.trim().isEmpty) {
        return 'Por favor, completa todos los campos.';
      }

      // Uso de modelo
      final nuevaPromocion = PromocionModel(
        titulo: titulo.trim(),
        descripcion: descripcion.trim(),
        fecha: DateTime.now(),
        estado: estado,
      );

      // llamada al servicio
      await _firebaseService.addPromocion(nuevaPromocion);
      return null;
    } catch (e) {
      return 'Error al registrar la promoción: $e';
    }
  }
}
