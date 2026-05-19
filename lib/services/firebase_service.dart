import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/item_model.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getPromociones() async{
  List promociones = [];
  CollectionReference collectionReferencePromociones = db.collection('Promociones');
  QuerySnapshot queryPromociones = await collectionReferencePromociones.get();

  queryPromociones.docs.forEach((documento) {
    promociones.add(documento.data());
    });

  return promociones;
}
