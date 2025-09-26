import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recuperaliss/presentation/cubits/person_cubit.dart';
import 'package:recuperaliss/model/person_model.dart';
import 'package:recuperaliss/presentation/person_state.dart';
import 'package:recuperaliss/presentation/screen/edit_card_dialog.dart';
import 'package:recuperaliss/presentation/screen/delete_card_dialog.dart';
import 'package:recuperaliss/presentation/screen/register_card_dialog.dart';
import 'package:recuperaliss/repository/person_repository.dart';
import 'package:recuperaliss/presentation/screen/loading_indicator.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => PersonCubit(personRepository: PersonRepository()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch people when the widget is initialized
    context.read<PersonCubit>().getPeople();
  }

  void _editCard(Person person) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditCardDialog(
          person: person,
          onNameChanged: (value) {
            context.read<PersonCubit>().updatePerson(person.copyWith(name: value));
          },
          onEmailChanged: (value) {
            context.read<PersonCubit>().updatePerson(person.copyWith(email: value));
          },
        );
      },
    );
  }

  void _deleteCard(Person person) {
    showConfirmDeleteDialog(
      context,
      person.name,
      () {
        context.read<PersonCubit>().deletePerson(person.id);
      },
    );
  }

  void _registerCard() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RegisterCardDialog(
          onRegister: () {
            context.read<PersonCubit>().getPeople(); // Refresh list after adding
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocBuilder<PersonCubit, PersonState>(
        builder: (context, state) {
          if (state is PersonLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PersonError) {
            return Center(child: Text(state.message));
          } else if (state is PersonSuccess) {
            final people = state.people;

            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // Mostrar 4 tarjetas por fila
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: people.length,
                    itemBuilder: (context, index) {
                      final person = people[index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: Colors.grey.shade300, width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Center(
                                child: Image.network(
                                  'https://cdn-icons-png.flaticon.com/512/17593/17593656.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Card ${person.id}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Name: ',
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: person.name,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Email: ',
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: person.email,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 5.0),
                                    child: OutlinedButton(
                                      onPressed: () => _editCard(person),
                                      child: const Text('Editar'),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.purple,
                                        side: BorderSide(color: Colors.purple, width: 2),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 5.0),
                                    child: OutlinedButton(
                                      onPressed: () => _deleteCard(person),
                                      child: const Text('Eliminar'),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.red,
                                        side: BorderSide(color: Colors.red, width: 2),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    onPressed: _registerCard,
                    tooltip: 'Add Card',
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
