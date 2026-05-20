import '../models/item_model.dart';
import '../services/firebase_service.dart';

class PromocionController {
  final FirebaseService _firebaseService = FirebaseService();

  // Expone el Stream procesado del servicio directamente a la Vista
  Stream<List<PromocionModel>> get streamPromociones =>
      _firebaseService.obtenerPromocionesStream();

  // Valida y ejecuta el registro
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
      await _firebaseService.registrarPromocion(nuevaPromocion);
      return null;
    } catch (e) {
      return 'Error al registrar la promoción: $e';
    }
  }

  // Valida y ejecuta la edición
  Future<String?> modificarPromocion({
    required String? id,
    required String titulo,
    required String descripcion,
    required DateTime fecha,
    required bool estado,
  }) async {
    try {
      if (id == null || id.isEmpty) {
        return 'Error: El ID de la promocion es requerido.';
      }
      if (titulo.trim().isEmpty || descripcion.trim().isEmpty) {
        return 'Campos vacios.';
      }

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

  // Eliminar promocion
  Future<String?> eliminarPromocion({required String? id}) async {
    try {
      if (id == null || id.isEmpty) {
        return 'Error: El ID de la promocion es requerido.';
      }
      await _firebaseService.eliminarPromocion(id);
      return null; // Éxito
    } catch (e) {
      return 'Error al eliminar: $e';
    }
  }
}
