import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recuperaliss/presentation/cubits/person_cubit.dart';
import 'package:recuperaliss/model/person_model.dart';
import 'package:recuperaliss/presentation/person_state.dart';
import 'package:recuperaliss/presentation/screen/edit_card_dialog.dart';
import 'package:recuperaliss/presentation/screen/delete_card_dialog.dart';
import 'package:recuperaliss/presentation/screen/register_card_dialog.dart';
import 'package:recuperaliss/repository/person_repository.dart';
import 'package:recuperaliss/presentation/screen/loading_indicator.dart'; // Importa el widget de loading

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final PersonRepository repository = PersonRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<DataCubit>(
          create: (context) => DataCubit(repository: repository)..getData(),
        ),
      ],
      child: MaterialApp(
        title: 'recupera pre extra',
        home: DataTablePerson(),
      ),
    );
  }
}

class DataTablePerson extends StatelessWidget{
  @override 
  Widget build (BuildContext context){
    return Scaffold(
      body:BlocBuilder<DataCubit, DataState>(
        builder: (context,state){
          if(state is PersonLoading){
            return Center(
              child: CircularProgressIndicator();
            );
          }else if(state is PersonSuccess){
            List<Person> people= state.people;
            return Center(
              child:SingleChilScrollView(
                scrollDirection:Axis.horizontal,
                child:DataTable(
                  columns:[
                    DataColumn(label:Text("#")),
                    DataColumn(label:Text("Nombre")),
                    DataColumn(label:Text("Email")),
                    DataColumn(label:Text("Acciones"))
                  ],
                  rows: people.asMap().entries.map((entry) {
                    int index = entry.key + 1;
                    var person= entry.value;
                    return DataRow(
                      cells:[
                        DataCell(Text('$index')),
                        DataCell(Text(person.name)),
                        DataCell(Text(person.email)),
                        DataCell(
                          Row(
                            children:[
                              IconButton(
                                icon:Icons(Icon.update),
                                onPressed:(){

                                }
                              ),
                              IconButton(
                                icon:Icons(Icon.delete),
                                onPressed:(){

                                }
                              ),
                              IconButton(
                                icon:Icons(Icon.remove_red_eye_sharp),
                                onPressed:(){

                                }
                              ),
                            ]
                          ),
                        ),
                      ]);
                    }).toList(),
                ),
              ),
            );
          }else{
            return Center(
              child:Text("Sin personas registradas")
            )
          }
        }
      )
    )
  }
}
