import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recuperaliss/model/person_model.dart';
import 'package:recuperaliss/presentation/cubits/person_cubit.dart';

class RegisterCardDialog extends StatefulWidget {
  final Function? onRegister;

  const RegisterCardDialog({super.key, this.onRegister});

  @override
  RegisterCardDialogState createState() => RegisterCardDialogState();
}

class RegisterCardDialogState extends State<RegisterCardDialog> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String email;
  late String url;

  @override
  void initState() {
    super.initState();
    name = '';
    email = '';
    url = '';
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    setState(() {
      name = '';
      email = '';
      url = '';
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registro Exitoso'),
          content: const Text('La persona ha sido registrada exitosamente.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Cierra el diálogo de registro también
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Registrar Persona'),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                onSaved: (value) => name = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Este es un campo obligatorio' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (value) => email = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Este es un campo obligatorio' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'URL'),
                onSaved: (value) => url = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Este es un campo obligatorio' : null,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final person = Person(
                          id: 0,
                          name: name,
                          email: email,
                          avatar: url,
                        );
                        BlocProvider.of<PersonCubit>(context).savePerson(person).then((_) {
                          _showSuccessDialog();
                          widget.onRegister?.call();
                        }).catchError((e) {
                          // Manejar errores si es necesario
                        });
                      }
                    },
                    child: const Text('Registrar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 185, 147, 228), // Color de fondo del botón
                      foregroundColor: Colors.white, // Color del texto del botón
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _clearForm();
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 204, 101, 93), // Color del texto del botón
                    ),
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
