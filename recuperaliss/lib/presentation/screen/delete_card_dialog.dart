import 'package:flutter/material.dart';

Future<void> showConfirmDeleteDialog(
  BuildContext context,
  String cardNumber,
  VoidCallback onConfirm,
) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmar Eliminación'),
        content: Text('¿Estás seguro de que quieres eliminar la Tarjeta $cardNumber?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo de confirmación
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo de confirmación
              _showSuccessDialog(context);
              onConfirm(); // Ejecutar la acción de eliminación
            },
            child: const Text('Eliminar'),
          ),
        ],
      );
    },
  );
}

void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Eliminación Exitosa'),
        content: const Text('La persona ha sido eliminada exitosamente.'),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo de éxito
            },
          ),
        ],
      );
    },
  );
}
