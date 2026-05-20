import '../models/item_model.dart';
import '../services/firebase_service.dart';

class DisplayController {
  final FirebaseService _firebaseService = FirebaseService();

  // Expone el Stream procesado del servicio directamente a la Vista
  Stream<List<PromocionModel>> get streamPromociones => _firebaseService.obtenerPromocionesStream();

}