
class ItemModels {
  final int ? id;
  final String titulo;
  final String descripcion;
  final DateTime fecha;
  final bool estado;

  ItemModels({
    this.id,
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.estado
  });
}