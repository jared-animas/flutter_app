import 'package:cloud_firestore/cloud_firestore.dart';

class PromocionModel {
  final String ? id;
  final String titulo;
  final String descripcion;
  final DateTime fecha;
  final bool estado;

  PromocionModel ({
    this.id,
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.estado
  });

  factory PromocionModel.fromMap(String documentId, Map<String, dynamic> map) {
    return PromocionModel(
      id: documentId,
      titulo: map['Titulo'] ?? '',
      descripcion: map['Descripcion'] ?? '',
      // Convertimos el Timestamp de Firebase de vuelta a un DateTime de Dart
      fecha: (map['Fecha'] as Timestamp).toDate(),
      estado: map['Estado'] ?? false,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'Titulo': titulo,
      'Descripcion': descripcion,
      'Fecha': fecha,
      'Estado': estado,
    };
  }
}

