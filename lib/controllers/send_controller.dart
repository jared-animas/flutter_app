import '../services/firebase_service.dart';

class SendController {
  final FirebaseService _firebaseService = FirebaseService();

  /// Simulación de envío
  Future<String?> registrarEnvio(String? id) async {
    try {
      if (id == null || id.isEmpty) return 'ID no válido.';

      // fecha actual para la simulacion
      await _firebaseService.registrarEnvioPromocion(id, DateTime.now());

      return null;
    } catch (e) {
      return 'Error en la simulación de envío: $e';
    }
  }
}
