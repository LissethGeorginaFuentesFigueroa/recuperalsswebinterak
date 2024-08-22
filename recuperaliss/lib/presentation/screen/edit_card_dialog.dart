import 'package:flutter/material.dart';
import 'package:recuperaliss/model/person_model.dart';

class EditCardDialog extends StatelessWidget {
  final Person person;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onEmailChanged;

  const EditCardDialog({
    Key? key,
    required this.person,
    required this.onNameChanged,
    required this.onEmailChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController(text: person.name);
    final _emailController = TextEditingController(text: person.email);

    void _showSuccessDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Actualización Exitosa'),
            content: const Text('La persona ha sido actualizada exitosamente.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); // Cierra el diálogo de edición también
                },
              ),
            ],
          );
        },
      );
    }

    return AlertDialog(
      title: const Text('Editar Persona'),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
              onChanged: onNameChanged,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: onEmailChanged,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            onNameChanged(_nameController.text);
            onEmailChanged(_emailController.text);
            _showSuccessDialog();
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
