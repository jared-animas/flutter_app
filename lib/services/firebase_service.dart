import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/item_model.dart';

const dbName = 'Promociones';


class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Actualizar datos en tiempo real
  Stream<List<PromocionModel>> obtenerPromocionesStream() {
    return _db.collection(dbName).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return PromocionModel.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

// Obtener promociones
  Future<List<PromocionModel>> getPromociones() async {
    final snapshot = await _db.collection(dbName).get();

    return snapshot.docs.map((doc) {
      return PromocionModel.fromMap(doc.id, doc.data());
    }).toList();
  }

  // Agregar promocion
  Future<void> addPromocion(PromocionModel promocion) async {
    await _db.collection(dbName).add(promocion.toMap());
  }

  // Actualizar promocion
  Future<void> actualizarPromocion(String id, PromocionModel promocion) async {
    await _db.collection(dbName).doc(id).update(promocion.toMap());
  }

  // Eliminar promocion
  Future<void> eliminarPromocion(String id) async {
    await _db.collection(dbName).doc(id).delete();
  }

}



