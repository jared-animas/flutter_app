import 'package:cloud_firestore/cloud_firestore.dart';

class PromocionModel {
  final String? id;
  final String titulo;
  final String descripcion;
  final DateTime fecha;
  final bool estado;
  final DateTime? fechaEnvio;
  final bool enviado;

  PromocionModel({
    this.id,
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.estado,
    this.fechaEnvio,
    this.enviado = false,
  });

  factory PromocionModel.fromMap(String documentId, Map<String, dynamic> map) {
    return PromocionModel(
      id: documentId,
      titulo: map['Titulo'] ?? '',
      descripcion: map['Descripcion'] ?? '',
      fecha: (map['Fecha'] as Timestamp).toDate(),
      estado: map['Estatus'] ?? false,
      fechaEnvio: map['FechaEnvio'] != null
          ? (map['FechaEnvio'] as Timestamp).toDate()
          : null,
      enviado: map['Enviado'] ?? false,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'Titulo': titulo,
      'Descripcion': descripcion,
      'Fecha': fecha,
      'Estatus': estado,
      'FechaEnvio': fechaEnvio,
      'Enviado': enviado,
    };
  }
}
