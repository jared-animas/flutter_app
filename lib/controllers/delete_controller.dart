import '../services/firebase_service.dart';

class DeleteController {
  final FirebaseService _firebaseService = FirebaseService();

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
